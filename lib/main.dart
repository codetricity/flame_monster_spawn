import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:math';

void main() {
  var game = MyGame();
  runApp(GameWidget(game: game));
}

class MyGame extends BaseGame with HasTappableComponents {
  Random randomX = Random();
  Random randomY = Random();
  List<Monster> monsters = [];

  Timer interval = Timer(0.6, repeat: true);
  int monsterIndex = 0;
  int maxMonster = 10;

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < 10; i++) {
      Monster monster = Monster();

      monster
        ..sprite = await loadSprite('alien.webp')
        ..position =
            Vector2(randomX.nextDouble() * 800, randomY.nextDouble() * 500)
        ..size = Vector2(100, 100);
      monsters.add(monster);
      // add(monster);
    }

    interval.callback = () {
      var currentMonster = monsters[monsterIndex];
      print('new monster spawned at ${currentMonster.position}');
      add(currentMonster);

      monsterIndex++;
    };
    interval.start();

    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (monsterIndex < maxMonster) {
      interval.update(dt);
    } else {
      interval.stop();
    }
  }
}

class Monster extends SpriteComponent with Tappable {
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      remove();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
