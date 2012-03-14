//
//  GameControlsLayer.h
//  OpenSpace
//
//  Created by Kulikov Alexey on 01.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h" 
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SpaceShip.h"
#import "BulletCache.h"

@interface GameControlsLayer : CCLayer {
    SneakyJoystick *leftJoystick; 
    SneakyButton *fireButtonMain;
    SneakyButton *fireButtonSecondary;
    
    //this is just a pointer to the GameplayLayer Object
    SpaceShip *mainSpaceShip;
    BulletCache *mainSpaceShipBulletCache;
}

-(void)initJoystickAndButtons;
-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)deltaTime;


@property(nonatomic, assign) SpaceShip *mainSpaceShip;
@property(nonatomic, assign) BulletCache *mainSpaceShipBulletCache;

@end
