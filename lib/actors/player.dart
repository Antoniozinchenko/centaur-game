import 'package:centaur/main.dart';
import 'package:flutter/services.dart';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

import '../compmonents/arrow.dart';

class Player extends PositionComponent
    with KeyboardHandler, HasGameRef<MyGame> {
  late SMITrigger fire;
  late SMINumber direction;
  double moveSpeedY = 100;
  double moveSpeedX = 30;
  @override
  Future<void> onLoad() async {
    final artboard = await loadArtboard(
      RiveFile.asset('assets/centaur.riv'),
      artboardName: 'Character',
    );
    final animationController = StateMachineController.fromArtboard(
      artboard,
      'Motion',
    )!;
    fire = animationController.findSMI<SMITrigger>('Fire')!;
    direction = animationController.findSMI<SMINumber>('Move')!;

    artboard.addController(animationController);
    final centaur = RiveComponent(
      artboard: artboard,
      size: Vector2.all(300),
    );
    add(centaur);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (direction.value != 0) {
      x += dt * moveSpeedX * direction.value;
      y += dt * moveSpeedY * direction.value;
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      direction.value = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      direction.value = 1;
    } else {
      direction.value = 0;
    }

    if (keysPressed.contains(LogicalKeyboardKey.space) && game.arrows < 2) {
      fire.value = true;
      final arrow = Arrow(800)
        ..x = x
        ..y = y;
      game.arrows++;
      game.add(arrow);
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
