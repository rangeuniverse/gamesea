import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gamesea/game/ufo_movement.dart';
import 'package:gamesea/game/assets.dart';
import 'package:gamesea/game/configuration.dart';
import 'package:gamesea/game/flappy_ufo_game.dart';
import 'package:flutter/material.dart';

class Ufo extends SpriteGroupComponent<UfoMovement>
    with HasGameRef<FlappyUfoGame>, CollisionCallbacks {
  Ufo();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final ufoMidFlap = await gameRef.loadSprite(Assets.ufoMidFlap);
    final ufoUpFlap = await gameRef.loadSprite(Assets.ufoUpFlap);
    final ufoDownFlap = await gameRef.loadSprite(Assets.ufoDownFlap);

    gameRef.ufo;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = UfoMovement.middle;
    sprites = {
      UfoMovement.middle: ufoMidFlap,
      UfoMovement.up: ufoUpFlap,
      UfoMovement.down: ufoDownFlap,
    };

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.ufoVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = UfoMovement.down,
      ),
    );
    FlameAudio.play(Assets.flying);
    current = UfoMovement.up;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  void gameOver() {
    FlameAudio.play(Assets.collision);
    game.isHit = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }
}
