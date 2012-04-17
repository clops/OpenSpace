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
        
        self.anchorPoint = ccp(0,0);
        
        //init spaceship
        mainSpaceShip            = [SpaceShip spaceShipWithParentNode:self];
        mainSpaceShipBulletCache = [BulletCache bulletCacheWithParentNode:self];        
        
        //this is experimental
        enemySpaceShip           = [SpaceShip spaceShipWithParentNode:self];
        
        //per default zoomed out
        [self zoomTo:0.5f];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        fullScreenSize = CGPointMake(screenSize.width, screenSize.height);
        halfScreenSize = ccpMult(fullScreenSize, .5f);
        
        [mainSpaceShip  setPosition:CGPointMake(screenSize.width*0.2f / self.scale, screenSize.height)];
        [enemySpaceShip setPosition:CGPointMake(screenSize.width*0.8f / self.scale, screenSize.height)];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) prepareLayerZoomBetweenSpaceship{
    CGPoint mainSpaceShipPosition  = [mainSpaceShip position];
    CGPoint enemySpaceShipPosition = [enemySpaceShip position];
    
    float distance = powf(mainSpaceShipPosition.x - enemySpaceShipPosition.x, 2) + powf(mainSpaceShipPosition.y - enemySpaceShipPosition.y,2);
    distance = sqrtf(distance);
    
    /*
        Distance > 350 --> no zoom
        Distance < 100 --> maximum zoom
     */
    float myZoomLevel = 0.5f;
    if(distance < 100){ //maximum zoom in
        myZoomLevel = 1.0f;
    }else if(distance > 350){
        myZoomLevel = 0.5f;
    }else{
        myZoomLevel = 1.0f - (distance-100)*0.002f;
    }

    //CCLOG(@"Distance: %f, Zoom: %f", distance, myZoomLevel);

    [self zoomTo:myZoomLevel];
}

-(void) zoomTo:(float)zoom {
    if(zoom > 1){
        zoom = 1;
    }
        
    // Set the scale.
    if(self.scale != zoom){
        self.scale = zoom;        
    }        
    
    CGPoint scaledMidpoint = ccpMult(ccpMidpoint(mainSpaceShip.position, enemySpaceShip.position), self.scale);
    self.position = ccpSub(halfScreenSize, scaledMidpoint);
}



-(void) update:(ccTime)delta {
    [self prepareLayerZoomBetweenSpaceship];
}



-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    // never forget to call [super dealloc]    
    [super dealloc]; 
}

@end
