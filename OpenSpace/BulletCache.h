//
//  BulletCache.h
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode 
{
	CCSpriteBatchNode* batch;
	int nextInactiveBullet;
}

+(id) bulletCacheWithParentNode:(CCNode *)parentNode;
-(id) initWithParentNode:(CCNode *)parentNode;
-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)velocity rotation:(float)rotation frameName:(NSString*)frameName;

@end
