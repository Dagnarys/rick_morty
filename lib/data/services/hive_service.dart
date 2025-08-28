import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_morty/data/models/character_model.dart';

class HiveService {
  static const String charactersBox = 'characters_box';
  static const String favoritesBox = 'favorites_box';
  static bool _isInitialized = false;

  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(CharacterAdapter());
      }
      await Hive.openBox<Character>(charactersBox);
      await Hive.openBox<int>(favoritesBox);
      _isInitialized = true;
    }
  }

  static Future<void> cacheCharacters(List<Character> characters) async {
    await _ensureInitialized();
    final box = Hive.box<Character>(charactersBox);
    await box.clear();

    for (final character in characters) {
      await box.put(character.id, character);
    }
  }

  static Future<List<Character>> getCachedCharacters() async {
    await _ensureInitialized();
    final box = Hive.box<Character>(charactersBox);
    final characters = box.values.toList();

    return characters;
  }

  static Future<bool> hasCachedData() async {
    await _ensureInitialized();
    final box = Hive.box<Character>(charactersBox);
    return box.isNotEmpty;
  }

  static Future<void> addToFavorites(int characterId) async {
    final box = Hive.box<int>(favoritesBox);
    await box.put(characterId, characterId);
  }

  static Future<void> removeFromFavorites(int characterId) async {
    final box = Hive.box<int>(favoritesBox);
    await box.delete(characterId);
  }

  static List<int> getFavoriteIds() {
    final box = Hive.box<int>(favoritesBox);
    return box.values.toList();
  }

  static bool isFavorite(int characterId) {
    final box = Hive.box<int>(favoritesBox);
    return box.containsKey(characterId);
  }

  static Future<void> clearCache() async {
    final characters = Hive.box<Character>(charactersBox);
    final favorites = Hive.box<int>(favoritesBox);
    await characters.clear();
    await favorites.clear();
  }
}
