class Character {

  final int id;
  final String name;
  final String image;
  final String species;
  final bool favorite;
  Character({
    required this.name, 
    required this.image, 
    required this.species, 
    required this.id,
    this.favorite = false
  });
   Character.fromJson(Map<String,dynamic> json, this.favorite):
   id = json['id'] as int,
   name = json['name'] as String,
   image = json['image'] as String,
   species = json['species'] as String;
}