import 'package:flutter/material.dart';
import 'package:rick_morty/data/models/character_model.dart';

class CharacterCard extends StatelessWidget {
   final Character character;
  const CharacterCard({super.key, required this.character});
 
  @override
  Widget build(BuildContext context) {
    return 
        Center(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                color: const Color.fromARGB(255, 230, 252, 131),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      character.image,
                      width: 150,
                      height: 150,
                    ),
                    Text(character.name),
                    Text(character.species),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  iconSize: 35,
                  onPressed: () {},
                  icon: Icon(character.favorite?Icons.favorite:Icons.favorite_outline),
                ),
              ),
            ],
          ),
        );
      
    
  }
}
