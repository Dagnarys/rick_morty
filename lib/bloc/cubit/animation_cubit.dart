// animation_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';


class AnimationCubit extends Cubit<Map<int, bool>> {
  AnimationCubit() : super({});

  void triggerFavoriteAnimation(int characterId, bool isFavorite) {
    final newState = Map<int, bool>.from(state);
    newState[characterId] = true;
    emit(newState);

    Future.delayed(Duration(milliseconds: 500), () {
      final resetState = Map<int, bool>.from(state);
      resetState.remove(characterId);
      emit(resetState);
    });
  }
}