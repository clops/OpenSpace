//
//  SpaceShip.m
//  OpenSpace
//
//  Created by Kulikov Alexey on 06.02.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpaceShip.h"


@implementation SpaceShip

// Static autorelease initializer, mimics cocos2d's memory allocation scheme. 
+(id) spaceShipWithParentNode:(CCNode*)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease]; 
}



// Creating an instance (from the static initializer)
-(id) initWithParentNode:(CCNode*)parentNode {
    CCLOG(@"Creating main Space Ship SELCTOR %@: %@", NSStringFromSelector(_cmd), self);
    
    if ((self = [super init])) {
        [parentNode addChild:self z:10 tag:666];

        //init spaceship hull
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //get the hull bro!
        hull = [CCSprite spriteWithSpriteFrameName:@"ufo-off.png"];        
        [hull setPosition:CGPointMake(screenSize.width*0.5, screenSize.height*0.5)];
        [self addChild:hull z:20 tag:666];
                
        
        //Basic Ship Properties
        rotationVelocity                = 6.0f;
        maximumRotationVelocity         = 3.0f;     //three is rather ok
        rotationVelocityDeterioration   = 0.05f;   
        
        maximumMovementVelocity         = 2.5f;
        movementVelocityDeterioration   = 0.005f;
        accelerationVelocity            = 0.3f;
        
        
        //init start position;
        [self setIsRotating:NO];
        [self setIsRotatingLeft:NO];
        [self setIsRotatingRight:NO];
        [self setIsAccelerating:NO];
        
        
        //start scheduler
        [self scheduleUpdate];
    }
    return self;
}


/***
 *  Sets movement vectors from the joystick input
 *  There is an (de)acceleration vector and a rotation vector that
 *  are controlled by the joystick.
 ***/
-(void) setVelocity:(CGPoint)velocity setRotation:(float)degrees {   
    
    //CCLOG(@"Degrees:%f Hull: %f, RT: %f", degrees, hull.rotation, (360-degrees));
    
    //only rotate in case the joystick has been touched
    if(degrees != 0){
        [self setRotatingToAngle:360-degrees+90];
    }
    
    [self setMovementVelocity:velocity];
}


/***
 *  This is the method that sets the movement velocity
 *  the update method will use this value to actually move the ship
 ***/ 
-(void) setMovementVelocity:(CGPoint)velocity {
    
    //no movement case
    if(velocity.x == 0 && velocity.y == 0){
        [self setIsAccelerating:NO];
        return;
    }
        
    if(hull.rotation - 22.5f < rotatingToAngle && hull.rotation + 22.5f > rotatingToAngle){
        //CCLOG(@"MOVE");
    }else{
        return;
    }
    
    //alternatively this line can be placed above the IF, then the engine will
    //rev prior to rotation
    [self setIsAccelerating:YES];    
    
    
    
    movementVelocity.x = movementVelocity.x + velocity.x*accelerationVelocity;
    movementVelocity.y = movementVelocity.y + velocity.y*accelerationVelocity;
    
    if(movementVelocity.x > maximumMovementVelocity){
        movementVelocity.x = maximumMovementVelocity;
    }else if(movementVelocity.x < -maximumMovementVelocity){
        movementVelocity.x = -maximumMovementVelocity;
    }

    if(movementVelocity.y > maximumMovementVelocity){
        movementVelocity.y = maximumMovementVelocity;
    }else if(movementVelocity.y < -maximumMovementVelocity){
        movementVelocity.y = -maximumMovementVelocity;
    }
}



/* ------- Acceleration Animation START -------------------------------------------------------------------- */
/*                                                                                                           */
-(void) setIsAccelerating:(_Bool)accelerating{
    if([self isAccelerating] != accelerating){
        isAccelerating = accelerating;
        
        if([self isAccelerating]){
            [self turnOnAccelerationEngines];
        }else{
            [self turnOffAccelerationEngines];        
        }
    }
}

-(bool) isAccelerating {
    return isAccelerating;
}

-(void) turnOnAccelerationEngines{
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo.png"];
    [hull setDisplayFrame:frame]; 
}

-(void) turnOffAccelerationEngines{
    //turn the engines off
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo-off.png"];
    [hull setDisplayFrame:frame];    
}
/*                                                                                                           */
/* ------- Acceleration Animation END ---------------------------------------------------------------------- */


/* ------- Rotation Animation START ------------------------------------------------------------------------ */
/*                                                                                                           */
-(void) setRotatingToAngle:(float)angle {
    if(angle > 360){
        angle = angle - 360;
    }
    
    CCLOG(@"Rotating to angle: %f", angle);
    
    rotatingToAngle = angle;
}

-(float) rotatingToAngle {
    return rotatingToAngle;
}

-(void) setIsRotating:(_Bool)rotating {
    if([self isRotating] != rotating){
        isRotating = rotating;
        
        if(![self isRotating]){
            [self setIsRotatingLeft:NO];
            [self setIsRotatingRight:NO];
            [self turnOffRotationEngines];
        }else{
            [self turnOnRotationEngines];        
        }
    }
}

-(bool) isRotating {
    return isRotating;
}

-(void) setIsRotatingLeft:(_Bool)rotating {
    if([self isRotatingLeft] != rotating){
        isRotatingLeft = rotating;
        
        if([self isRotatingLeft]){
            [self turnOnRotationLeftEngines];
        }else{
            [self turnOffRotationLeftEngines];        
        }
    }
}

-(bool) isRotatingLeft {
    return isRotatingLeft;
}

-(void) setIsRotatingRight:(_Bool)rotating {
    if([self isRotatingRight] != rotating){
        isRotatingRight = rotating;
        
        if([self isRotatingRight]){
            [self turnOnRotationRightEngines];
        }else{
            [self turnOffRotationRightEngines];        
        }
    }
}

-(bool) isRotatingRight {
    return isRotatingRight;
}

-(void) turnOnRotationEngines {
    //nothing
}

-(void) turnOffRotationEngines {
    //nothing
}

-(void) turnOnRotationLeftEngines {
    //if(abs((int)([self rotatingToAngle] - hull.rotation)) > 2){
        CCSpriteFrame *frame;
        if([self isAccelerating]){
            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo-left.png"];
        }else{
            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo-off-left.png"];    
        }

        [hull setDisplayFrame:frame];   
    //}
}

-(void) turnOffRotationLeftEngines {
    if([self isAccelerating]){
        [self turnOnAccelerationEngines];
    }else{
        [self turnOffAccelerationEngines];
    }
}

-(void) turnOnRotationRightEngines {
    //if(abs((int)(hull.rotation - [self rotatingToAngle])) > 2){    
        CCSpriteFrame *frame;
        if([self isAccelerating]){
            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo-right.png"];
        }else{
            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"ufo-off-right.png"];    
        }
    
        [hull setDisplayFrame:frame];   
    //}
}

-(void) turnOffRotationRightEngines {
    if([self isAccelerating]){
        [self turnOnAccelerationEngines];
    }else{
        [self turnOffAccelerationEngines];
    }
}

/*                                                                                                           */
/* ------- Rotation Animation END -------------------------------------------------------------------------- */



/***
 *  Calculate Rotation with Rotation Accelleration / Decelleration
 ***/
-(void) calculateRotation:(ccTime)delta {
    //zero and 360 are equeal values in a circle
    if([self rotatingToAngle] == 360){
        [self setIsRotating:NO];
        return;
    }
    
    //calculate this once
    float adjustedRotationVelocity = rotationVelocity*delta*60;
    
    
    if([self rotatingToAngle] <= hull.rotation + adjustedRotationVelocity && [self rotatingToAngle] > hull.rotation - adjustedRotationVelocity){
        [self setIsRotating:NO];
        return;
    }
       
    //maybe there is some cool animation?
    [self setIsRotating:YES];    
    
    //do we have to rotate?
    if(hull.rotation > [self rotatingToAngle]){
        if(hull.rotation - 180 > [self rotatingToAngle]){
            hull.rotation = hull.rotation + adjustedRotationVelocity;
            [self setIsRotatingRight:YES];    
        }else{
            hull.rotation = hull.rotation - adjustedRotationVelocity;
            [self setIsRotatingLeft:YES];    
        }
    }else if(hull.rotation < [self rotatingToAngle]){
        if(hull.rotation + 180 < [self rotatingToAngle]){
            hull.rotation = hull.rotation - adjustedRotationVelocity;            
            [self setIsRotatingLeft:YES];    
        }else{
            hull.rotation = hull.rotation + adjustedRotationVelocity;            
            [self setIsRotatingRight:YES];    
        }
    }
    
    if(hull.rotation > 360){
        hull.rotation = 0;
    }else if(hull.rotation < 0){
        hull.rotation = 360;
    }
    
    //deteriorate
    //rotationVelocity = rotationVelocity - rotationVelocityDeterioration;
}



-(void) calculateMovement:(ccTime)delta {   
    CGSize screenSize = [[CCDirector sharedDirector] winSize];    
    CGPoint newPosition = hull.position;
    
    newPosition.x = newPosition.x + movementVelocity.x*delta*60;
    newPosition.y = newPosition.y + movementVelocity.y*delta*60;

    if(newPosition.x > screenSize.width){
        newPosition.x = 0;
    }else if(newPosition.x < 0){
        newPosition.x = screenSize.width;
    }

    if(newPosition.y > screenSize.height){
        newPosition.y = 0;
    }else if(newPosition.y < 0){
        newPosition.y = screenSize.height;
    }

    hull.position = newPosition;
    
    //deteriorate movement velocity
    if(movementVelocity.x > 0){
        movementVelocity.x = movementVelocity.x - movementVelocityDeterioration;
    }else if(movementVelocity.x < 0){
        movementVelocity.x = movementVelocity.x + movementVelocityDeterioration;    
    }

    if(movementVelocity.y > 0){
        movementVelocity.y = movementVelocity.y - movementVelocityDeterioration;
    }else if(movementVelocity.y < 0){
        movementVelocity.y = movementVelocity.y + movementVelocityDeterioration;    
    }
}


-(CGPoint) position {
    return hull.position;
}

-(float) rotation {
    return hull.rotation;
}

-(CGPoint) shootingDirection {
    //the math here is simple, 2pi is 360deg
    //and the shooting direction is basically a derivative 
    //of the hull's rotation (unless this is some special weapon, right)
    float xVector = sin(hull.rotation*0.0174f)*500;
    float yVector = cos(hull.rotation*0.0174f)*500;
    
    return CGPointMake(xVector,yVector);
}

-(void) update:(ccTime)delta {
    [self calculateRotation:delta];
    [self calculateMovement:delta];
}



-(void) dealloc {
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[super dealloc];
}

@end
