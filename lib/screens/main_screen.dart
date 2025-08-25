import 'package:flutter/material.dart';
import 'package:rick_morty/widgets/bottom_navigation.dart';
import 'package:rick_morty/widgets/character_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty'), centerTitle: true),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        scrollDirection: Axis.vertical,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(0),
            child: CharacterCard(),
          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        child: BottomNavigation(),
      ),
    );
  }
}
