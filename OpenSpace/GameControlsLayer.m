//
//  GameControlsLayer.m
//  OpenSpace
//
//  Created by Kulikov Alexey on 01.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameControlsLayer.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"

@implementation GameControlsLayer
@synthesize mainSpaceShip;
@synthesize mainSpaceShipBulletCache;
-(id)init{
    if ((self = [super init])) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.isTouchEnabled = YES;  
        
        [self initJoystickAndButtons];
        [self scheduleUpdate]; 
    }
    
    return self;
}


-(void)initJoystickAndButtons {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 256.0f, 256.0f);
    CGRect fireButtonMainDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    
    CGPoint joystickBasePosition;
    CGPoint fireButtonMainPosition;
    
    CCLOG(@"Positioning Joystick and Buttons for iPhone");
    joystickBasePosition = ccp(screenSize.width*0.16f,
                               screenSize.height*0.24f);
    
    fireButtonMainPosition = ccp(screenSize.width*0.93f,
                               screenSize.height*0.15f);
    
    //create the joystick
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"joystickbase.png"];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickstick.png"];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoystick = [joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position = fireButtonMainPosition;
    
    jumpButtonBase.defaultSprite = [CCSprite spriteWithFile:@"buttonUp.png"];
    jumpButtonBase.activatedSprite = [CCSprite spriteWithFile:@"buttonDown.png"];
    jumpButtonBase.pressSprite = [CCSprite spriteWithFile:@"buttonDown.png"];
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:fireButtonMainDimensions];
    
    fireButtonMain = [jumpButtonBase.button retain];
    fireButtonMain.isToggleable = NO;
    [self addChild:jumpButtonBase];
}


-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)deltaTime{
    [mainSpaceShip setVelocity:aJoystick.velocity setRotation:aJoystick.degrees];    
    
    if(fireButtonMain.active){
        CCLOG(@"Attack button is pressed.");
        [mainSpaceShipBulletCache shootBulletAt:[mainSpaceShip position] velocity:[mainSpaceShip shootingDirection] rotation:[mainSpaceShip rotation] frameName:@"bullet.png"];        
    }
}


-(void) update:(ccTime)deltaTime{
    [self applyJoystick:leftJoystick forTimeDelta:deltaTime];
}


-(void) dealloc {
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    
    // never forget to call [super dealloc]    
    [super dealloc]; 
}


@end
