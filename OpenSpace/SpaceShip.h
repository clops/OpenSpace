//
//  SpaceShip.h
//  OpenSpace
//
//  Created by Kulikov Alexey on 06.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SpaceShip : CCNode {
    CCSprite* hull;
    
    //current engine state
    float rotationVelocity;
    CGPoint movementVelocity; //current movement vector
        
    //set ship properties
    float maximumRotationVelocity;
    float rotationVelocityDeterioration;
    
    float maximumMovementVelocity;
    float movementVelocityDeterioration;
    float accelerationVelocity;
    
    //current state of ship
    float rotatingToAngle;
    
    bool isRotating;
    bool isRotatingLeft;
    bool isRotatingRight;
    bool isAccelerating;
}

+(id) spaceShipWithParentNode:(CCNode *)parentNode;
-(id) initWithParentNode:(CCNode *)parentNode;

-(void) setVelocity:(CGPoint)velocity setRotation:(float)degrees;
-(void) setMovementVelocity:(CGPoint)velocity;

-(CGPoint) shootingDirection;

-(void) calculateRotation:(ccTime)delta;
-(void) calculateMovement:(ccTime)delta;

-(void) turnOnAccelerationEngines;
-(void) turnOffAccelerationEngines;

-(void) turnOnRotationEngines;
-(void) turnOffRotationEngines;

-(void) turnOnRotationLeftEngines;
-(void) turnOffRotationLeftEngines;

-(void) turnOnRotationRightEngines;
-(void) turnOffRotationRightEngines;

@property(readwrite) float rotatingToAngle;
@property(readwrite) bool isRotating;
@property(readwrite) bool isRotatingLeft;
@property(readwrite) bool isRotatingRight;
@property(readwrite) bool isAccelerating;

@end
