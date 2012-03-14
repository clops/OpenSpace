//
//  GameplayLayer.m
//  OpenSpace
//
//  Created by Alexey Kulikov on 30.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"
#import "CCTouchDispatcher.h"
#import "SpaceShip.h"

@implementation GameplayLayer

@synthesize mainSpaceShip;
@synthesize mainSpaceShipBulletCache;

-(id)init{
    if ((self = [super init])) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        //self.isTouchEnabled = YES;  
        
        //init spaceship
        mainSpaceShip            = [SpaceShip spaceShipWithParentNode:self];
        mainSpaceShipBulletCache = [BulletCache bulletCacheWithParentNode:self];        
    }
    
    return self;
}





-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    // never forget to call [super dealloc]    
    [super dealloc]; 
}

@end
