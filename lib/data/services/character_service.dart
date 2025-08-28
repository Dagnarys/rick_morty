import 'package:dio/dio.dart';
import 'package:rick_morty/data/models/character_model.dart';
import 'package:rick_morty/data/services/hive_service.dart';

class CharacterService {
  final dio = Dio();

  Future<List<Character>> getCharacters({bool forceRefresh = false}) async {

    final hasCachedData = await HiveService.hasCachedData();
    if (!forceRefresh && hasCachedData) {
      try {

        final cachedCharacters = await HiveService.getCachedCharacters();
        final charactersWithFavorites =  _updateFavoritesStatus(cachedCharacters);
        
        return charactersWithFavorites;
      } catch (e) {
        print('Ошибка загрузки из кеша: $e');
        // Продолжаем с сетевой загрузкой
      }
    }
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character',
        options: Options(headers: {'Cache-Control': 'no-cache'}),
      );
      if (response.statusCode == 200) {
        final characters =
            (response.data['results'] as List)
                .map((json) => Character.fromJson(json, false))
                .toList();

        final charactersWithFavorites = _updateFavoritesStatus(characters);
        await HiveService.cacheCharacters(charactersWithFavorites);

        return charactersWithFavorites;
      }
    } on DioException catch (e) {
      print(e.message);

      rethrow;
    }

    return [];
  }

  List<Character> _updateFavoritesStatus(List<Character> characters) {
    final favoriteIds = HiveService.getFavoriteIds();

    return characters.map((character) {
      return Character(
        id: character.id,
        name: character.name,
        image: character.image,
        species: character.species,
        favorite: favoriteIds.contains(character.id),
      );
    }).toList();
  }
}
