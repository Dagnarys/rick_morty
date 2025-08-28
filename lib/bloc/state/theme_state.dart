abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

// BLoC состояние
class ThemeState {
  final bool isDarkMode;
  final String currentImage;
  ThemeState({required this.isDarkMode, required this.currentImage});
  static const String lightImage = 'assets/img/bg_img2.png';
  static const String darkImage = 'assets/img/mock.png';
  factory ThemeState.dark() {
    return ThemeState(isDarkMode: true, currentImage: darkImage);
  }
    factory ThemeState.light() {
    return ThemeState(isDarkMode: false, currentImage: lightImage);
  }
}
