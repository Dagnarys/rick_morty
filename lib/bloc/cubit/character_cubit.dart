import 'package:bloc/bloc.dart';
import 'package:rick_morty/bloc/state/character_state.dart';

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
}