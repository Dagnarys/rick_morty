import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

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
                      'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                      width: 150,
                      height: 150,
                    ),
                    Text('Rick'),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  iconSize: 35,
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                ),
              ),
            ],
          ),
        );
      
    
  }
}
