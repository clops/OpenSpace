//
//  GameplayLayer.h
//  OpenSpace
//
//  Created by Alexey Kulikov on 30.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceShip.h"
#import "BulletCache.h"
#import "ParallaxBackground.h"

@interface GameplayLayer : CCLayer {
    SpaceShip *mainSpaceShip;
    BulletCache *mainSpaceShipBulletCache;
    
    SpaceShip *enemySpaceShip;
    //BulletCache *bulletCache;
    
    ParallaxBackground* background;
    
    CGPoint halfScreenSize;
    CGPoint fullScreenSize;
    float   smallestZoomLevel;
    float   minimalZoomingDistance;
    float   zoomScaleStep;
}

-(void) zoomTo:(float)zoom;
-(void) prepareLayerZoomBetweenSpaceship;

@property(nonatomic, assign) SpaceShip *mainSpaceShip;
@property(readonly, nonatomic) BulletCache* mainSpaceShipBulletCache;

@end
