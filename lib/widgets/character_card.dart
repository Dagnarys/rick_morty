import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/character_cubit.dart';
import 'package:rick_morty/data/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            color: const Color.fromARGB(255, 230, 252, 131),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.network(character.image, width: 170, height: 170),

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
              onPressed: () {
                context.read<CharacterCubit>().toggleFavorite(character.id);
              },
              icon: Icon(
                character.favorite ? Icons.star : Icons.star_border_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
