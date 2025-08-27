import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/character_cubit.dart';
import 'package:rick_morty/bloc/state/character_state.dart';
import 'package:rick_morty/widgets/bottom_navigation.dart';
import 'package:rick_morty/widgets/character_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
            'Избранное',
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
            final favoriteCharacters =
                context.read<CharacterCubit>().favoriteCharacters;
            if (state is CharacterLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (favoriteCharacters.isEmpty) {
              return Center(
                child: Text(
                  'Добавьте персонажа',
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
            if (state is CharacterLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('data'),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1, 
                        crossAxisSpacing: 12, 
                        childAspectRatio: 0.8, 
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: favoriteCharacters.length,
                      itemBuilder: (context, index) {
                        final character = favoriteCharacters[index];
                        return Container(
                          padding: const EdgeInsets.all(0),
                          child: CharacterCard(character: character),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('Данные не найдены'));
          },
        ),
      ),
    );
  }
}
