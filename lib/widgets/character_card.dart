import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/cubit/character_cubit.dart';
import 'package:rick_morty/bloc/cubit/theme_cubit.dart';
import 'package:rick_morty/bloc/cubit/animation_cubit.dart';
import 'package:rick_morty/data/models/character_model.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCirc,
      ),
    );

    _colorAnimation = ColorTween(
      begin: null,
      end: Colors.red.withValues(alpha: 0.5),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation(bool isAddingToFavorites) {
    if (isAddingToFavorites) {
      // Анимация добавления - увеличение
      _controller.forward().then((_) {
        _controller.reverse();
      });
    } else {
      // Анимация удаления - красный цвет
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimationCubit, Map<int, bool>>(
      listener: (context, animationState) {
        final shouldAnimate = animationState[widget.character.id] ?? false;
        if (shouldAnimate) {
          _triggerAnimation(widget.character.favorite);
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: _colorAnimation.value ?? 
                    (context.read<ThemeCubit>().state.isDarkMode
                        ? const Color.fromARGB(255, 37, 40, 41)
                        : Color.fromARGB(255, 230, 252, 131)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        widget.character.image,
                        width: 170,
                        height: 170,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/img/mock.png',
                            width: 170,
                            height: 170,
                          );
                        },
                      ),
                      Text(
                        widget.character.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.read<ThemeCubit>().state.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        widget.character.species,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.read<ThemeCubit>().state.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      iconSize: 35,
                      onPressed: () {
                        final animationCubit = context.read<AnimationCubit>();
                        final characterCubit = context.read<CharacterCubit>();
                        
                        // Запускаем анимацию
                        animationCubit.triggerFavoriteAnimation(
                          widget.character.id, 
                          !widget.character.favorite
                        );
                        
                        // Переключаем избранное
                        characterCubit.toggleFavorite(widget.character.id);
                      },
                      icon: Icon(
                        widget.character.favorite 
                            ? Icons.star 
                            : Icons.star_border_outlined,
                        color: widget.character.favorite 
                            ? const Color.fromARGB(255, 243, 88, 16) 
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}