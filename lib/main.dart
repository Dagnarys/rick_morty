import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/character_cubit.dart';
import 'package:rick_morty/data/services/character_service.dart';
import 'package:rick_morty/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  CharacterCubit(characterService: CharacterService())
                    ..loadCharacters(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen()
      ),
    );
  }
}
