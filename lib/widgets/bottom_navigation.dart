import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/theme_cubit.dart';
import 'package:rick_morty/bloc/state/theme_state.dart';
import 'package:rick_morty/screens/favorite_screen.dart';
import 'package:rick_morty/screens/main_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color:
                    themeState.isDarkMode
                        ? const Color.fromARGB(255, 121, 118, 118)
                        : Colors.black,
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
                color:
                    themeState.isDarkMode
                        ? const Color.fromARGB(255, 121, 118, 118)
                        : Colors.black,
                icon: Icon(Icons.star, size: 44),
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
      },
    );
  }
}
