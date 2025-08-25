import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/character_cubit.dart';
import 'package:rick_morty/bloc/state/character_state.dart';

import 'package:rick_morty/widgets/bottom_navigation.dart';
import 'package:rick_morty/widgets/character_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty'), centerTitle: true),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        child: BottomNavigation(),
      ),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CharacterLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return Container(
                  padding: const EdgeInsets.all(0),
                  child: CharacterCard(character: character),
                );
              },
            );
          }
          return Center(child: Text('Данные не найдены'));
        },
      ),
    );
  }
}
