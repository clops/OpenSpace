//
//  ParallaxBackground.h
//  OpenSpace
//
//  Created by Kulikov Alexey on 18.04.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode {
    CGPoint shiftVelocity;
}

+(id) backgroundWithParentNode:(CCNode *)parentNode;
-(id) initWithParentNode:(CCNode *)parentNode;

-(void)shiftFrom:(CGPoint)fromPosition to:(CGPoint)toPosition;
@end
