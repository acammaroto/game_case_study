import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_case_study/helpers/directions.dart';
import 'package:game_case_study/helpers/map_loarder.dart';
import 'package:game_case_study/player.dart';
import 'package:game_case_study/world.dart';
import 'package:game_case_study/world_collidable.dart';

class RayWorldGame extends FlameGame with HasCollidables {
  final Player _player = Player();
  final World _world = World();

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    await add(_world);
    addWorldCollision();
    add(_player);
    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });
}
