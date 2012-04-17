//
//  GameScene.m
//  OpenSpace
//
//  Created by Alexey Kulikov on 30.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"

@implementation GameScene

+(id) scene {
    CCScene *scene = [CCScene node]; 
    
    //base space layer
    CCLayer *layer = [GameScene node]; 
    [scene addChild:layer z:1];
    
    //the actual gameplay layer
    GameplayLayer *gameplayLayer = [GameplayLayer node];
    [scene addChild:gameplayLayer z:GameSceneLayerTagGame tag:GameSceneLayerTagGame];
    
    //the input layer above it
    GameControlsLayer *gamecontrolsLayer = [GameControlsLayer node];
    [scene addChild:gamecontrolsLayer z:GameSceneLayerTagInput tag:GameSceneLayerTagInput];
    
    //tie the two together (pass a pointer from the shop in the gameplaylayer to the controllayer)
    [gamecontrolsLayer setMainSpaceShip:[gameplayLayer mainSpaceShip]];
    [gamecontrolsLayer setMainSpaceShipBulletCache:[gameplayLayer mainSpaceShipBulletCache]];

    //[gameplayLayer setScale:0.4f];
    //[gameplayLayer zoomTo:0.5f];
    //gameplayLayer.scale = 0.5f;

    return scene;
}

-(id) init {
    if ((self = [super init])) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);     
        
        //open the texture atlas
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"game-art.plist"];         
        
        //preload sounds
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"laser.mp3"];        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"ufo.mp3"];        
    }
    return self;
}



-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    // never forget to call [super dealloc]
    [super dealloc]; 
}

@end