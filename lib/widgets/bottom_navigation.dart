import 'package:flutter/material.dart';
import 'package:rick_morty/screens/favorite_screen.dart';
import 'package:rick_morty/screens/main_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, size: 44),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite, size: 44),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
