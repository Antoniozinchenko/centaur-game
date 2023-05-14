import 'dart:math';

import 'package:centaur/main.dart';
import 'package:flame/components.dart';

import '../actors/zombie.dart';

class ZombieRespawn extends PositionComponent with HasGameRef<MyGame> {
  late Timer spawnInterval;

  @override
  Future<void> onLoad() async {
    size.y = game.size.y;
    size.x = 10;
    x = game.size.x;
    anchor = Anchor.topRight;
    spawnInterval = Timer(
      1,
      repeat: true,
      onTick: () {
        final randomY = Random().nextDouble() * (size.y - 300);
        final zombie = Zombie();
        zombie.y = randomY;
        game.add(zombie);
      }
    );

    return super.onLoad();
  }
  @override
    void update(double dt) {
      spawnInterval.update(dt);
      super.update(dt);
    }
}
