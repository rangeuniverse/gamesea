import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:gamesea/components/background.dart';
import 'package:gamesea/components/ufo.dart';
import 'package:gamesea/components/ground.dart';
import 'package:gamesea/components/pipe_group.dart';
import 'package:gamesea/game/configuration.dart';
import 'package:flutter/painting.dart';

class FlappyUfoGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyUfoGame();

  late Ufo ufo;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      ufo = Ufo(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }

  @override
  void onTap() {
    ufo.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${ufo.score}';
  }
}
