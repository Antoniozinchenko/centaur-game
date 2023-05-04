import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'actors/player.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  bool get debugMode => false;

  @override
  Color backgroundColor() {
    return const Color(0xFF6c8450);
  }

  @override
  Future<void> onLoad() async {
    await add(Player());
    await super.onLoad();
  }
  int arrows = 0;
}
