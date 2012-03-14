//
//  BulletCache.m
//

#import "BulletCache.h"
#import "Bullet.h"

@implementation BulletCache

+(id) bulletCacheWithParentNode:(CCNode *)parentNode {
    return [[[self alloc] initWithParentNode:parentNode] autorelease]; 
}


-(id) initWithParentNode:(CCNode *)parentNode {
    CCLOG(@"Creating Bullet Cache SELECTOR %@: %@", NSStringFromSelector(_cmd), self);
    
    if ((self = [super init])) {
        // get any bullet image from the Texture Atlas we're using        
		CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
        
		// use the bullet's texture (which will be the Texture Atlas used by the game)
		batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
		[self addChild:batch];
		
        CCLOG(@"Creating 50 Bullets");
		// Create a number of bullets up front and re-use them whenever necessary.
		for (int i = 0; i < 50; i++) {
			Bullet* bullet = [Bullet bullet];
			bullet.visible = NO;
			[batch addChild:bullet];
		}
        
        [parentNode addChild:self z:1];
    }
    return self;
}



-(void) dealloc {
	[super dealloc];
}


-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)velocity rotation:(float)rotation frameName:(NSString*)frameName {
	CCArray* bullets = [batch children];
	CCNode* node = [bullets objectAtIndex:nextInactiveBullet];
    
    CCLOG(@"Fetching node from index %d", nextInactiveBullet);
	NSAssert([node isKindOfClass:[Bullet class]], @"not a Bullet!"); //LEARN THIS
	
	Bullet* bullet = (Bullet*)node;
	[bullet shootBulletAt:startPosition velocity:velocity rotation:rotation frameName:frameName];
	
	nextInactiveBullet++;
	if (nextInactiveBullet >= [bullets count]) {
		nextInactiveBullet = 0;
	}
}

@end
