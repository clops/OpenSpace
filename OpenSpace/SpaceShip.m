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


static CGRect screenRect; //stored as a static variable for performance reasons



-(id) initWithParentNode:(CCNode *)parentNode {
    CCLOG(@"Creating main Space Ship SELCTOR %@: %@", NSStringFromSelector(_cmd), self);
    
    if ((self = [super init])) {
        [parentNode addChild:self z:10 tag:666];

        // make sure to initialize the screen rect only once
		if (CGRectIsEmpty(screenRect)){
			CGSize screenSize = [[CCDirector sharedDirector] winSize];
			screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		}

        
        //get the hull bro!
        hull = [CCSprite spriteWithSpriteFrameName:@"ufo-off.png"];        
        //[hull setPosition:CGPointMake(screenRect.size.width*location, screenRect.size.height)];
        [self addChild:hull z:20 tag:666];
        
        
        //Basic Ship Properties
        rotationVelocity                = 6.0f;
        maximumRotationVelocity         = 3.0f;     //three is rather ok
        rotationVelocityDeterioration   = 0.05f;   
        
        maximumMovementVelocity         = 3.0f;
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
        
    if([self rotation] - 22.5f < rotatingToAngle && [self rotation] + 22.5f > rotatingToAngle){
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
    
    //sound!
    //[[SimpleAudioEngine sharedEngine] playEffect:@"ufo.mp3"];
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
    
    //CCLOG(@"Rotating to angle: %f", angle);
    
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
    
    
    if([self rotatingToAngle] <= [self rotation] + adjustedRotationVelocity && [self rotatingToAngle] > [self rotation] - adjustedRotationVelocity){
        [self setIsRotating:NO];
        return;
    }
       
    //maybe there is some cool animation?
    [self setIsRotating:YES];    
    
    //do we have to rotate?
    float newRotation;
    if([self rotation] > [self rotatingToAngle]){
        if([self rotation] - 180 > [self rotatingToAngle]){
            newRotation = [self rotation] + adjustedRotationVelocity;
            [self setIsRotatingRight:YES];    
        }else{
            newRotation = [self rotation] - adjustedRotationVelocity;
            [self setIsRotatingLeft:YES];    
        }
    }else if([self rotation] < [self rotatingToAngle]){
        if([self rotation] + 180 < [self rotatingToAngle]){
            newRotation = [self rotation] - adjustedRotationVelocity;            
            [self setIsRotatingLeft:YES];    
        }else{
            newRotation = [self rotation] + adjustedRotationVelocity;            
            [self setIsRotatingRight:YES];    
        }
    }
    
    if([self rotation] > 360){
        newRotation = 0;
    }else if([self rotation] < 0){
        newRotation = 360;
    }
    
    [self setRotation:newRotation];
    //deteriorate
    //rotationVelocity = rotationVelocity - rotationVelocityDeterioration;
}



-(void) calculateMovement:(ccTime)delta {   
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];    
    CGPoint newPosition = [self position];
    
    newPosition.x = newPosition.x + movementVelocity.x*delta*60;
    newPosition.y = newPosition.y + movementVelocity.y*delta*60;
    

    /* TEMPORARY 
    if(newPosition.x > screenRect.size.width){
        newPosition.x = 0;
    }else if(newPosition.x < 0){
        newPosition.x = screenRect.size.width;
    }

    if(newPosition.y > screenRect.size.height){
        newPosition.y = 0;
    }else if(newPosition.y < 0){
        newPosition.y = screenRect.size.height;
    }
    */

    //hull.position = newPosition;
    [self setPosition:newPosition];
    
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


-(CGPoint) shootingDirection {
    //the math here is simple, 2pi is 360deg
    //and the shooting direction is basically a derivative 
    //of the hull's rotation (unless this is some special weapon, right)
    float xVector = sin([self rotation]*0.0174f)*500;
    float yVector = cos([self rotation]*0.0174f)*500;
    
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
