//
//  ParallaxBackground.m
//  OpenSpace
//
//  Created by Kulikov Alexey on 18.04.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackground.h"

@implementation ParallaxBackground

// Static autorelease initializer, mimics cocos2d's memory allocation scheme. 
+(id) backgroundWithParentNode:(CCNode*)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease]; 
}

-(id) initWithParentNode:(CCNode *)parentNode {
    CCLOG(@"Creating Parallax Background %@: %@", NSStringFromSelector(_cmd), self);
    
    if ((self = [super init])) {
        
        CCSprite *bg = [CCSprite spriteWithFile:@"space.jpg" rect:CGRectMake(-10000, -10000, 10000, 10000)];
        [bg setPosition:ccp(0, 0)];
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [bg.texture setTexParameters:&params];
        [self addChild:bg z:-1];
        
        
        [parentNode addChild:self z:-1];
        //start scheduler
        //[self scheduleUpdate];
    }
    return self;
}

-(void) shiftFrom:(CGPoint)fromPosition to:(CGPoint)toPosition{
    shiftVelocity = ccpSub(toPosition, fromPosition);
}

-(void) update:(ccTime)delta {
    //[parallax updateWithVelocity:ccp(shiftVelocity.x, 0) AndDelta:delta];
}

@end
