import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/state/theme_state.dart';

class ThemeCubit extends Bloc<ThemeEvent, ThemeState> {
  ThemeCubit() : super(ThemeState.light()) {
    on<ToggleThemeEvent>((event, emit) {
      state.isDarkMode ? emit(ThemeState.light()) : emit(ThemeState.dark());
    });
  }
  void toggleTheme(){
    add(ToggleThemeEvent());
  }
}
