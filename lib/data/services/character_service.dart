import 'package:dio/dio.dart';
import 'package:rick_morty/data/models/character_model.dart';

class CharacterService {
  final dio = Dio();

  Future<List<Character>> getCharacters({bool forceRefresh = false}) async {
    var response;
    try {
      response = await dio.get('https://rickandmortyapi.com/api/character');
    } on DioException catch (e) {
      print(e.message);
    }

    return (response.data['results'] as List)
        .map((json) => Character.fromJson(json, false))
        .toList();
  }
}
