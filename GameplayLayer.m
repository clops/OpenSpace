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
        
        //create background
        background               = [ParallaxBackground backgroundWithParentNode:self];        
        
        //init spaceship
        mainSpaceShip            = [SpaceShip spaceShipWithParentNode:self];
        mainSpaceShipBulletCache = [BulletCache bulletCacheWithParentNode:self];        
        
        //this is experimental
        enemySpaceShip           = [SpaceShip spaceShipWithParentNode:self];
        
        //zoom settings
        minimalZoomingDistance   = 450;
        smallestZoomLevel        = 0.5f;
        zoomScaleStep            = (1.0 - smallestZoomLevel) / (minimalZoomingDistance - 100);
        
        //per default zoomed out
        [self zoomTo:smallestZoomLevel];
        
        //set layer dimensions
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        fullScreenSize = CGPointMake(screenSize.width, screenSize.height);
        halfScreenSize = ccpMult(fullScreenSize, .5f);
        
        //position ships
        [mainSpaceShip  setPosition:CGPointMake(screenSize.width*0.2f / self.scale, screenSize.height)];
        [enemySpaceShip setPosition:CGPointMake(screenSize.width*0.8f / self.scale, screenSize.height)];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) prepareLayerZoomBetweenSpaceship{    
    float distance = ccpDistance(mainSpaceShip.position, enemySpaceShip.position);
    
    /*
        Distance > minimalZoomingDistance --> no zoom
        Distance < 100 --> maximum zoom
     */
    float myZoomLevel = smallestZoomLevel; //I presume we are zoomed out as an init value
    if(distance < 100){ //maximum zoom in
        myZoomLevel = 1.0f;
    }else if(distance > minimalZoomingDistance){
        myZoomLevel = smallestZoomLevel;
    }else{
        myZoomLevel = 1.0f - (distance-100)*zoomScaleStep;
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
    
    //center the layer between two ships
    CGPoint scaledMidpoint  = ccpMult(ccpMidpoint(mainSpaceShip.position, enemySpaceShip.position), self.scale);
    CGPoint newPosition     = ccpSub(halfScreenSize, scaledMidpoint);
    
    //[background shiftFrom:self.position to:newPosition];
    
    
    self.position           = newPosition;
    
    //also reposition the ships if they are offscreen X
    if(fabs(mainSpaceShip.position.x - enemySpaceShip.position.x) > 960){
        float tempPosition = mainSpaceShip.position.x;
        mainSpaceShip.position = CGPointMake(enemySpaceShip.position.x, mainSpaceShip.position.y);
        enemySpaceShip.position = CGPointMake(tempPosition, enemySpaceShip.position.y);
    }

    //and Y
    if(fabs(mainSpaceShip.position.y - enemySpaceShip.position.y) > 480){
        float tempPosition = mainSpaceShip.position.y;
        mainSpaceShip.position = CGPointMake(mainSpaceShip.position.x, enemySpaceShip.position.y);
        enemySpaceShip.position = CGPointMake(enemySpaceShip.position.x, tempPosition);
    }
}



-(void) update:(ccTime)delta {
    [self prepareLayerZoomBetweenSpaceship];
    
    //CCLOG(@"Layer Pos: %f", self.position.x);
}



-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    // never forget to call [super dealloc]    
    [super dealloc]; 
}

@end
