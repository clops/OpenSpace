//
//  Bullet.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import "Bullet.h"


@interface Bullet (PrivateMethods)
-(id) initWithBulletImage;
@end

@implementation Bullet
@synthesize velocity;

+(id) bullet {
	return [[[self alloc] initWithBulletImage] autorelease];
}

static CGRect screenRect; //stored as a static variable for performance reasons


-(id) initWithBulletImage {
	if ((self = [super initWithSpriteFrameName:@"bullet.png"])) {
        //CCLOG(@"Created Bullet!");
        
		// make sure to initialize the screen rect only once
		if (CGRectIsEmpty(screenRect)){
			CGSize screenSize = [[CCDirector sharedDirector] winSize];
			screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		}
	}
	
	return self;
}


// Re-Uses the bullet
-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel rotation:(float)rotation frameName:(NSString*)frameName {
    CCLOG(@"Shooting from: %f, %f at: %f, %f", startPosition.x, startPosition.y, vel.x, vel.y);
    
	self.velocity = vel;
	self.position = startPosition;
	self.visible = YES;
    self.rotation = rotation;
	
	// change the bullet's texture by setting a different SpriteFrame to be displayed
	CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
	[self setDisplayFrame:frame];
	
	[self unscheduleUpdate];
	[self scheduleUpdate];
}


-(void) update:(ccTime)delta {
	self.position = ccpAdd(self.position, ccpMult(velocity, delta));
	
	// When the bullet leaves the screen, make it invisible
	if (CGRectIntersectsRect([self boundingBox], screenRect) == NO){
		self.visible = NO;
		[self unscheduleUpdate];
	}
}

@end
