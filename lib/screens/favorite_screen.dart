import 'package:flutter/material.dart';
import 'package:rick_morty/widgets/bottom_navigation.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(child: Text('asd')),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        child: BottomNavigation(),
      ),
    );
  }
}