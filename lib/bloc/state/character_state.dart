import 'package:rick_morty/data/models/character_model.dart';

abstract class CharacterState{
  const CharacterState();
  List<Object> get props => [];
}
class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  
  const CharacterLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;
  
  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}