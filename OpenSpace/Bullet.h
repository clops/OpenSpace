//
//  Bullet.h
//  OpenSpace
//
//  Created by Kulikov Alexey on 07.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



@interface Bullet : CCSprite 
{
	CGPoint velocity;
}

@property (readwrite, nonatomic) CGPoint velocity;

+(id) bullet;

-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel rotation:(float)rotation frameName:(NSString*)frameName;


@end

