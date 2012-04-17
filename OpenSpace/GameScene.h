//
//  GameScene.h
//  OpenSpace
//
//  Created by Alexey Kulikov on 30.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameplayLayer.h"
#import "GameControlsLayer.h"

typedef enum {
    GameSceneLayerTagGame = 10,
    GameSceneLayerTagInput = 100, 
} GameSceneLayerTags;

typedef enum {
    GameSceneNodeTagBulletCache
} GameSceneAccessors;

typedef enum {
    PlayerShip,
    EnemyShip
} spaceShips;

@interface GameScene : CCLayer {
    
}

+(id) scene;

@end
