import 'package:gamesea/game/assets.dart';
import 'package:gamesea/game/flappy_ufo_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyUfoGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.message),
        ),
      ),
    );
  }
}
