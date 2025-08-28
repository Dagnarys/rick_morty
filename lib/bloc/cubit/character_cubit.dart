import 'package:bloc/bloc.dart';
import 'package:rick_morty/bloc/state/character_state.dart';
import 'package:rick_morty/data/models/character_model.dart';

import 'package:rick_morty/data/services/character_service.dart';
import 'package:rick_morty/data/services/hive_service.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterService characterService;
  CharacterCubit({required this.characterService}) : super(CharacterInitial());

  Future<void> loadCharacters() async {
    try {
      emit(CharacterLoading());

      final characters = await characterService.getCharacters();
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError('Failed to load: $e'));
    }
  }

  Future<void> refreshCharacters() async {
    try {
      final characters = await characterService.getCharacters(
        forceRefresh: true,
      );
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError('Failed to refresh characters: $e'));
    }
  }

  void toggleFavorite(int characterId) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final character = currentState.characters.firstWhere(
        (character) => character.id == characterId,
      );
      if (character.favorite) {
        await HiveService.removeFromFavorites(characterId);
      } else {
        await HiveService.addToFavorites(characterId);
      }
      final updatedCharacters =
          currentState.characters.map((character) {
            if (character.id == characterId) {
              return Character(
                id: character.id,
                name: character.name,
                image: character.image,
                species: character.species,
                favorite: !character.favorite, // Меняем статус
              );
            }
            return character;
          }).toList();

      emit(CharacterLoaded(updatedCharacters));
    }
  }

  List<Character> get favoriteCharacters {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final favorites =
          currentState.characters.where((c) => c.favorite).toList();

      return _sortFavorites(favorites);
    }
    return [];
  }

  String _favoritesSortBy = 'name';

  String get favoritesSortBy => _favoritesSortBy;

  void changeFavoritesSorting(String sortBy) {
    _favoritesSortBy = sortBy;
     if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      emit(CharacterLoaded(currentState.characters)); 
    }
  }

  List<Character> _sortFavorites(List<Character> favorites) {
    final sorted = List<Character>.from(favorites);
    if (_favoritesSortBy == 'name') {
      sorted.sort((a, b) => a.name.compareTo(b.name));
    } else {
      sorted.sort((a, b) => a.id.compareTo(b.id));
    }
    return sorted;
  }
}
