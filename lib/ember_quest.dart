import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:platformer/actors/ember.dart';
import 'package:platformer/actors/water_enemy.dart';
import 'package:platformer/managers/segment_manager.dart';
import 'package:platformer/objects/ground_block.dart';
import 'package:platformer/objects/platform_block.dart';
import 'package:platformer/objects/star.dart';

class EmberQuestGame extends FlameGame{
  late EmberPlayer _ember;
  double objectSpeed = 0.0;
  EmberQuestGame();

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void initializeGame(){
    //x < 3200
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++){
      loadGameSegments(i, (640*i).toDouble());
    }

    _ember = EmberPlayer(position: Vector2(128, canvasSize.y - 70),
    );

    world.add(_ember);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset){
    for (final block in segments[segmentIndex]){
      switch (block.blockType){
        case GroundBlock:
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          break;
        case WaterEnemy:
          break;
      }
    }
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png'
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame();
  }
}