import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class Character {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final bool favorite;
  Character({
    required this.name,
    required this.image,
    required this.species,
    required this.id,
    this.favorite = false,
  });
  factory Character.fromJson(Map<String, dynamic> json, bool favorite) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      species: json['species'] as String,
      favorite: favorite,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'species': species,
      'favorite': favorite,
    };
  }
}
