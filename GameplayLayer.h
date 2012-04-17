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

@interface GameplayLayer : CCLayer {
    SpaceShip *mainSpaceShip;
    BulletCache *mainSpaceShipBulletCache;
    
    SpaceShip *enemySpaceShip;
    //BulletCache *bulletCache;
    
    CGPoint halfScreenSize;
    CGPoint fullScreenSize;
}

-(void) zoomTo:(float)zoom;
-(void) prepareLayerZoomBetweenSpaceship;

@property(nonatomic, assign) SpaceShip *mainSpaceShip;
@property(readonly, nonatomic) BulletCache* mainSpaceShipBulletCache;

@end
