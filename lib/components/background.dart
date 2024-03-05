import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gamesea/game/assets.dart';
import 'package:gamesea/game/flappy_ufo_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyUfoGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.backgorund);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
