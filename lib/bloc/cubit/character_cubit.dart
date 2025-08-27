import 'package:bloc/bloc.dart';
import 'package:rick_morty/bloc/state/character_state.dart';
import 'package:rick_morty/data/models/character_model.dart';

import 'package:rick_morty/data/services/character_service.dart';

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

  void toggleFavorite(int characterId) {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
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
    return (state as CharacterLoaded).characters
        .where((character) => character.favorite)
        .toList();
    
  }
}
