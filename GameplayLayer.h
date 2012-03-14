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
    //BulletCache *bulletCache;
}

@property(nonatomic, assign) SpaceShip *mainSpaceShip;
@property(readonly, nonatomic) BulletCache* mainSpaceShipBulletCache;

@end
