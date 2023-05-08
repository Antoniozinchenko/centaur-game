import 'package:centaur/compmonents/arrow.dart';
import 'package:centaur/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class Zombie extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  late SMITrigger hit;
  double speed = -100;
  Timer? dead;

  void die() {
    if (dead == null) {
      hit.value = true;
      dead = Timer(
        4,
        onTick: () => game.remove(this),
      );
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (dead == null && other is Arrow) {
      die();
      other.dispose();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (dead == null) {
      x += dt * speed;
      if (x < 0) {
        die();
      }
    }
    dead?.update(dt);
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    final artboard = await loadArtboard(
      RiveFile.asset('assets/zombie_character.riv'),
    );
    final zombie = RiveComponent(
      artboard: artboard,
      size: Vector2.all(300),
    );
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    )!;
    hit = controller.findSMI<SMITrigger>('Hit')!;
    artboard.addController(controller);

    add(zombie);
    x = game.size.x;
    add(RectangleHitbox(
      size: Vector2(100, 200),
      position: Vector2(90, 70),
    ));
    flipHorizontally();
    return super.onLoad();
  }
}
