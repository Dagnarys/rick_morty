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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/bg_img.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Rick and Morty',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),

                  scrollDirection: Axis.vertical,
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return CharacterCard(character: character);
                  },
                ),
              );
            }
            return Center(child: Text('Данные не найдены'));
          },
        ),
      ),
    );
  }
}
