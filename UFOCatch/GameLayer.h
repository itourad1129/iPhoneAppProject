//
//  HelloWorldLayer.h
//  UFOCatch
//
//  Created by 伊東 純平 on 2013/04/06.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface GameLayer : CCLayer
{
    CCSprite* arm_right;
    CCSprite* arm_left;
    CCSprite* back;
    CCSprite* ufo_ue;
    CCSprite* ufo_sita;
    CCSprite* prize;
    
    int score;
    CCLabelTTF *score_label;

    
    
    int left;
    int right;
    
    CCMenuItemImage *button1;
    CCMenu *Button1;
    
    CCMenuItemImage *button2;
    CCMenu *Button2;

    
    CCMenuItemImage *button3;
    CCMenu *Button3;

    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
