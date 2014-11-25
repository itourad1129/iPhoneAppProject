//
//  GameScene.h
//  racegame
//
//  Created by 伊東 純平 on 11/07/16.
//  Copyright 2011 北海道情報大学. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface GameScene : CCLayer
{
	CCSprite* rank1;
	CCSprite* rank2;
	CCSprite* rank3;
	CCSprite* rank4;
	CCSprite* rank5;
	CCSprite* ome;
	CCSprite* scoregamen;
	CCSprite* hiscoregamen;
	CCSprite* player;
	CCSprite* gameover;
	CCSprite* setumei;
	CCSprite* startgamen;
	CGPoint playerVelocity;
	
	
	CCArray* spiders;
	float spiderMoveDuration;
	int numSpidersMoved;
	ccTime totalTime;
	int score;
	CCLabelBMFont* scoreLabel;
	int hiscore;
	CCLabelBMFont* hiscoreLabel;
	int imode;
}

+(id) scene;

@end
