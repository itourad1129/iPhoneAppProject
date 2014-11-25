//
//  HelloWorldLayer.m
//  UFOCatch
//
//  Created by 伊東 純平 on 2013/04/06.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

// HelloWorldLayer implementation
@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
     left = 5;
     right = 0;
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        
        
		
        CGSize size = [[CCDirector sharedDirector] winSize];
		back = [CCSprite spriteWithFile:@"back.png"];
		[self addChild:back z:1];
		back.position = ccp( size.width /2 , size.height/2 );
        
        ufo_ue = [CCSprite spriteWithFile:@"UFO-ue.png"];
		[self addChild:ufo_ue z:2];
		ufo_ue.position = ccp( 70 , 270);
        
        ufo_sita = [CCSprite spriteWithFile:@"UFO-sita.png"];
		[self addChild:ufo_sita z:1];
		ufo_sita.position = ccp( ufo_ue.position.x , ufo_ue.position.y - 17);
        
        arm_right = [CCSprite spriteWithFile:@"arm-right.png"];
		[self addChild:arm_right z:1];
		arm_right.position = ccp( ufo_ue.position.x - 12 , ufo_ue.position.y - 70);
        
        arm_left = [CCSprite spriteWithFile:@"arm-left.png"];
		[self addChild:arm_left z:1];
		arm_left.position = ccp( ufo_ue.position.x + 12 , ufo_ue.position.y - 70);
        
        prize = [CCSprite spriteWithFile:@"prize.png"];
		[self addChild:prize z:3];
		prize.position = ccp( -100000 , -1000000);
        
        
       
        score = 10;
        NSString *str = [[NSString alloc] initWithFormat:@"%d", score];

        score_label = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:40];
        score_label.position =  ccp(420 , 30);
        [self addChild:score_label z:4];
        
        
        
        
        
        button1 = [CCMenuItemImage                           
                 itemFromNormalImage:@"button1.png"
                 selectedImage:@"button1-2.png"
                 target:self
                   selector:@selector(pressMenuLeftButton:)];
        
        Button1 = [CCMenu menuWithItems:button1, nil];
        
        
        
        
        
        button1.position = ccp(-110,-118); 
        
        
        [self addChild:Button1 z:7];
        
        button2 = [CCMenuItemImage                           
                   itemFromNormalImage:@"button2.png"
                   selectedImage:@"button2-2.png"
                   target:self
                   selector:@selector(pressMenuLeftButton2:)];
        
        Button2 = [CCMenu menuWithItems:button2, nil];
        
        
        
        button2.position = ccp(-30,-118); 
        
        
        [self addChild:Button2 z:7];
        
        button3 = [CCMenuItemImage                           
                   itemFromNormalImage:@"button3.png"
                   selectedImage:@"button3-2.png"
                   target:self
                   selector:@selector(pressMenuLeftButton3:)];
        
        Button3 = [CCMenu menuWithItems:button3, nil];
        
        
        
        button3.position = ccp(50,-118); //他のボタンを作る時は絶対値を記入する事。size.widthなどは使えない
        
        
        [self addChild:Button3 z:7];

        CCDelayTime* delay = [CCDelayTime actionWithDuration:1];
        CCCallBlock* func = [CCCallBlack actionWithBlock:^{(void){
            label.string = [NSString stringWithFormat:]
        }
        
        
	}
	return self;
}


- (void)pressMenuLeftButton:(id)sender{
    
    left = left + 1;
    right = right - 1;
    
    if(ufo_ue.position.x >= 150){
    
        
    CCMoveBy* gameAction = [CCMoveBy actionWithDuration:1 position:ccp( -70 , 0 )];
    [ufo_ue runAction:gameAction];
    CCMoveBy* gameAction2 = [CCMoveBy actionWithDuration:1 position:ccp( -70 , 0 )];
    [ufo_sita runAction:gameAction2];
    CCMoveBy* gameAction3 = [CCMoveBy actionWithDuration:1 position:ccp( -70 , 0 )];
    [arm_left runAction:gameAction3];
    CCMoveBy* gameAction4 = [CCMoveBy actionWithDuration:1 position:ccp( -70 , 0 )];
    [arm_right runAction:gameAction4];
    }
    
}

- (void)pressMenuLeftButton2 :(id)sender {

    right = right + 1;
    left = left - 1;

   
    
    if(ufo_ue.position.x <= 300){
        
    CCMoveBy* gameAction = [CCMoveBy actionWithDuration:1 position:ccp( 70 , 0 )];
    [ufo_ue runAction:gameAction];
    CCMoveBy* gameAction2 = [CCMoveBy actionWithDuration:1 position:ccp( 70 , 0 )];
    [ufo_sita runAction:gameAction2];
    CCMoveBy* gameAction3 = [CCMoveBy actionWithDuration:1 position:ccp( 70 , 0 )];
    [arm_left runAction:gameAction3];
    CCMoveBy* gameAction4 = [CCMoveBy actionWithDuration:1 position:ccp( 70 , 0 )];
    [arm_right runAction:gameAction4];
    }
    
    
}

- (void)pressMenuLeftButton3 :(id)sender {
    
    
    
    score = score - 1;
    
    CCMoveBy* gameAction4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 0 )];
    CCMoveBy* gameAction4_2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 0 )];
    CCMoveTo* gameAction4_3 = [CCMoveTo actionWithDuration:1 position:ccp( 400 , 270 )];
    CCMoveBy* gameAction4_4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 0 )];
    CCMoveBy* gameAction4_5 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 0 )];
    CCMoveTo* gameAction4_6 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x , 270 )];
    
    
    CCMoveBy* gameAction1 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction1_2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction1_3 = [CCMoveTo actionWithDuration:1 position:ccp( 400 , 253 )];
    CCMoveBy* gameAction1_4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction1_5 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction1_6 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x , 253 )];
    
    CCMoveBy* gameAction2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction2_2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction2_3 = [CCMoveTo actionWithDuration:1 position:ccp( 412 , 200 )];
    CCMoveBy* gameAction2_4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction2_5 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction2_6 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x  + 12 , 200 )];
    
    CCMoveBy* gameAction3 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction3_2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction3_3 = [CCMoveTo actionWithDuration:1 position:ccp( 388 , 200 )];
    CCMoveBy* gameAction3_4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction3_5 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction3_6 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x - 12 , 200 )];
    

    CCMoveTo* gameAction5 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x , ufo_ue.position.y - 150 )];
    CCMoveBy* gameAction5_2 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , 50 )];
    CCMoveTo* gameAction5_3 = [CCMoveTo actionWithDuration:1 position:ccp( 400 ,  ufo_ue.position.y - 100)];
    CCMoveBy* gameAction5_4 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , -50 )];
    CCMoveBy* gameAction5_5 = [CCMoveBy actionWithDuration:1 position:ccp( 0 , ufo_ue.position.y - 600 )];
    CCMoveTo* gameAction5_6 = [CCMoveTo actionWithDuration:1 position:ccp( ufo_ue.position.x , ufo_ue.position.y - 300 )];
    CCMoveTo* gameAction5_7 = [CCMoveTo actionWithDuration:0.1 position:ccp( ufo_ue.position.x , ufo_ue.position.y - 1000000 )];
    
    CCSequence* seq4 = [CCSequence actions:gameAction4,gameAction4_2,gameAction4_3,gameAction4_4,gameAction4_5,gameAction4_6, nil];
    [ufo_ue runAction:seq4];

    
    CCSequence* seq = [CCSequence actions:gameAction1,gameAction1_2,gameAction1_3,gameAction1_4,gameAction1_5,gameAction1_6, nil];
    [ufo_sita runAction:seq];
    
    CCSequence* seq2 = [CCSequence actions:gameAction2,gameAction2_2,gameAction2_3,gameAction2_4,gameAction2_5,gameAction2_6, nil];
    [arm_left runAction:seq2];
    
    CCSequence* seq3 = [CCSequence actions:gameAction3,gameAction3_2,gameAction3_3,gameAction3_4,gameAction3_5,gameAction3_6, nil];
    [arm_right runAction:seq3];
    
    CCSequence* seq5 = [CCSequence actions:gameAction5,gameAction5_2,gameAction5_3,gameAction5_4,gameAction5_5,gameAction5_6,gameAction5_7, nil];
    [prize runAction:seq5];

    NSString *str = [[NSString alloc] initWithFormat:@"%d", score];
    [score_label setString: [NSString stringWithFormat:@"%@",str]];

    
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
