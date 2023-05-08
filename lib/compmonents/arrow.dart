import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

import '../main.dart';

class Arrow extends PositionComponent with HasGameRef<MyGame> {
  Arrow(this.arrowSpeed);
  final double arrowSpeed;
  void dispose() {
      game.arrows--;
      game.remove(this);
  }

  @override
  void update(double dt) {
    if (x > game.size.x) {
      dispose();
    }
    x += dt * arrowSpeed;

    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    final artboard = await loadArtboard(
      RiveFile.asset('assets/centaur.riv'),
      artboardName: 'Arrow',
    );
    final arrow = RiveComponent(
      artboard: artboard,
      size: Vector2.all(300),
    )
      ..x = 60
      ..y = -10;
    add(arrow);

    add(RectangleHitbox(
      size: Vector2(100, 20),
      position: Vector2(150, 130),
    ));

    return super.onLoad();
  }
}
