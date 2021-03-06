//
//  GameScene.m
//  RaceGame
//
//  Created by 伊東 純平 on 11/07/16.
//  Copyright 2011 北海道情報大学. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"
@interface GameScene (PrivateMethods)
-(void) initSpiders;
-(void) resetSpiders;
-(void) spidersUpdate:(ccTime)delta;
-(void) runSpiderMoveSequence:(CCSprite*)spider;
-(void) spiderBelowScreen:(id)sender;
-(void) checkForCollision;
-(void) ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event;
@end

@implementation GameScene


+(id) scene
{
	CCScene *scene = [CCScene node];
	CCLayer* layer = [GameScene node];
	[scene addChild:layer];
	return scene;
}
-(id) init
{
	[[CCDirector sharedDirector] setDisplayFPS:NO];
	if ((self =[super init]))
	{
		
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gametyuu.caf"
														 loop:YES];
		
		imode = 1;
		CCLOG(@"%@: %@" , NSStringFromSelector(_cmd), self);
		
		self.isAccelerometerEnabled = YES;
		
		player = [CCSprite spriteWithFile:@"teki.png"];
		[self addChild:player z:4 tag:1];
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float imageHeight = [player texture].contentSize.height;
		player.position = CGPointMake(screenSize.width / 2, imageHeight / 2);
		
		// -(void) update:(ccTime)delta メソッドがフレームごとに呼び出されるようスケジュールする
		[self scheduleUpdate];
		
		[self initSpiders];
		
		// imode 1 スタート画面
		// imode 2 説明画面
		// imode 3 ゲームオーバー画面
		
		//CCSprite* background = [CCSprite spriteWithFile:@"miti.png"];
		//background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		//[self addChild:background z:imode];
		
		gameover = [CCSprite spriteWithFile:@"gameovergamen-1.png"];
		[self addChild:gameover z:5 tag:1];
		gameover.position = CGPointMake(1000, 1000);
		
		setumei = [CCSprite spriteWithFile:@"setumeigamen.png"];
		[self addChild:setumei z:7 tag:1];
		setumei.position = CGPointMake(1000, 1000);
		
		startgamen = [CCSprite spriteWithFile:@"startgamen.png"];
		[self addChild:startgamen z:7 tag:1];
		startgamen.position = CGPointMake(160, 240);
		
		scoregamen = [CCSprite spriteWithFile:@"sukoagamen-1.png"];
		[self addChild:scoregamen z:6 tag:1];
		scoregamen.position = CGPointMake(160, 240);
		
		hiscoregamen = [CCSprite spriteWithFile:@"haisukoagamen.png"];
		[self addChild:hiscoregamen z:6 tag:1];
		hiscoregamen.position = CGPointMake(160, 240);
		
		rank1 = [CCSprite spriteWithFile:@"rank1.png"];
		[self addChild:rank1 z:6 tag:1];
		rank1.position = CGPointMake(1000, 1000);
		
		rank2 = [CCSprite spriteWithFile:@"rank2.png"];
		[self addChild:rank2 z:6 tag:1];
		rank2.position = CGPointMake(1000, 1000);
		
		rank3 = [CCSprite spriteWithFile:@"rank3.png"];
		[self addChild:rank3 z:6 tag:1];
		rank3.position = CGPointMake(1000, 1000);
		
		rank4 = [CCSprite spriteWithFile:@"rank4.png"];
		[self addChild:rank4 z:6 tag:1];
		rank4.position = CGPointMake(1000, 1000);
		
		rank5 = [CCSprite spriteWithFile:@"rank5.png"];
		[self addChild:rank5 z:6 tag:1];
		rank5.position = CGPointMake(1000, 1000);
		
		ome = [CCSprite spriteWithFile:@"ome.png"];
		[self addChild:ome z:6 tag:1];
		ome.position = CGPointMake(1000, 1000);
		
		// Add the score label with z value of -1 so it's drawn below everything else
		scoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bmf.fnt"];
		scoreLabel.position = CGPointMake(screenSize.width / 2, screenSize.height);
		// Adjust the label's anchorPoint's y position to make it align with the top.
		scoreLabel.anchorPoint = CGPointMake(0.5f, 1.7f);
		[self addChild:scoreLabel z:5];
        
		// Add the score label with z value of -1 so it's drawn below everything else
		hiscoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bmf.fnt"];
		hiscoreLabel.position = CGPointMake(screenSize.width / 2, screenSize.height);
		// Adjust the label's anchorPoint's y position to make it align with the top.
		hiscoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
		[self addChild:hiscoreLabel z:5];
		self.isTouchEnabled = YES;
		
		
        
	}
	
	return self;
}
-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// spiders 配列は [CCArray alloc] で作成したもので解放しなければならない
	[spiders release];
	spiders = nil;
	
	// [super dealloc]を忘れずに呼び出すこと
	[super dealloc];
}
-(void) initSpiders
{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	
	
	// 画像サイズを所得するなら、
	// 一時的なスパイダースプライトを使って画像サイズゲット
	CCSprite* tempSpider = [CCSprite spriteWithFile:@"teki.png"];
	float imageWidth = [tempSpider texture].contentSize.width;
	
	// スクリーンの幅いっぱいにできるだけ多くのスパイダーを重ならないように使う
	int numSpiders = screenSize.width / imageWidth;
	
	// allocを使ってspiders配列を初期化する
	spiders = [[CCArray alloc] initWithCapacity:numSpiders];
	
	
    
	// BatchNodeにテクスチャを登録し、Layerに追加します。
	// effect512.pngの部分はご自分の環境に合わせて変更してください。
	CCSpriteBatchNode *batch = [CCSpriteBatchNode batchNodeWithFile:@"mitinoanime.png" capacity:1];
	[self addChild:batch];
	
	// アニメーションの最初のスプライトを読み込む
	CCSprite* sprite = [CCSprite spriteWithBatchNode:batch rect:CGRectMake(0, 0, 320, -480)];
	sprite.position = ccp(screenSize.width/2, screenSize.height/2);
	[batch addChild:sprite z:-3];
	
	// アニメーションのコマに対応するスプライトをフレームとして作成する
	NSMutableArray *animFrames = [NSMutableArray array];
	for(int s=0; s<6; s++) {
		CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:batch.texture
														  rect:CGRectMake(s*320, 480, 320, -480)];//左下から
		[animFrames addObject:frame];
	}
	
	// アニメーションフレームをアニメーションとしてスプライトと紐付ける
	// 無限に繰り返すアニメーション
	CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:0.014f];
	id repeatAnim = [CCRepeatForever actionWithAction:
					 [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
	[sprite runAction:repeatAnim];
    
	for (int i = 0; i < numSpiders; i++)
	{
		CCSprite* spider = [CCSprite spriteWithFile:@"teki.png"];
		[self addChild:spider z:0 tag:2];
		
		// 車をspiders配列に追加する6		[spiders addObject:spider];
	}
	
	// すべての車の位置を変更するメソッドを呼び出す
	[self resetSpiders];
}
-(void) resetSpiders
{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	// 任意のスパイダーからその画像の幅を所得する
	CCSprite* tempSpider = [spiders lastObject];
	CGSize size = [tempSpider texture].contentSize;
	
	int numSpiders = [spiders count];
	for (int i = 0; i < numSpiders; i++)
	{
		// 各スパイダーをスクリーンの外の所定の位置に置く
		CCSprite* spider = [spiders objectAtIndex:i];
		spider.position = CGPointMake(size.width * i + size.width * 0.5f,
									  screenSize.height + size.height);
		
		spider.scale = 1;
		
		[spider stopAllActions];
	}
	
	// 念のため、セレクタのスケジュールを解除する
	// スケジュールされていないければセレクタは何もしない
	[self unschedule:@selector(spidersUpdate:)];
	
	// スパイダー更新ロジックを指定された間で実行するようにスケジュールする
	[self schedule:@selector(spidersUpdate:) interval:0.6f];
	
	numSpidersMoved = 0;
	spiderMoveDuration = 3.0f; // 小さくするほど早くなる
	
	
	
}
-(void) spidersUpdate:(ccTime)delta
{
    
	// 現在動いていないスパイダーを探す
	for (int i = 0; i < 10; i++)
	{
		int randomSpiderIndex = CCRANDOM_0_1() * [spiders count];
		CCSprite* spider = [spiders objectAtIndex:randomSpiderIndex];
		
		// 動いていないスパイダーはアクションを実行していない
		if ([spider numberOfRunningActions] == 0)
		{
			// スパイダーの動きを制御するシーケンス
			[self runSpiderMoveSequence:spider];
			
			// 動き出すスパイダーは一度に1つだけ
			break;
		}
	}
}
-(void) runSpiderMoveSequence:(CCSprite*)spider
{
	// スパイダーの速度をゆっくり上昇させる
	numSpidersMoved++;
	if (numSpidersMoved % 4 == 0 && spiderMoveDuration > 2.0f)
	{
		spiderMoveDuration -= 0.1f;
	}
	
	// スパイダーの動きを制御するシーケンス
	CGPoint belowScreenPosition = CGPointMake(spider.position.x,
											  -[spider texture].contentSize.height);
	CCMoveTo* move = [CCMoveTo actionWithDuration:spiderMoveDuration
										 position:belowScreenPosition];
	CCCallFuncN* call = [CCCallFuncN actionWithTarget:self
											 selector:@selector(spiderBelowScreen:)];
	CCSequence* sequence = [CCSequence actions:move, call, nil];
	[spider runAction:sequence];
}
-(void) spiderBelowScreen:(id)sender
{
	// sender が実際に正しいクラスのオブジェクトであることを確認する
	NSAssert([sender isKindOfClass:[CCSprite class]],
			 @"sender is not a CCSprite!");
	CCSprite* spider = (CCSprite*)sender;
	
	// スパイダーを画面最上部の外側に戻す
	CGPoint pos = spider.position;
	
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	pos.y = screenSize.height + [spider texture].contentSize.height;
	spider.position = pos;
	if(score >= 5  && spider.position.y >= screenSize.height)
	{
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"kuruma.caf"];
	}
}

#pragma mark Accelerometer Input

-(void) accelerometer:(UIAccelerometer *)accelerometer
		didAccelerate:(UIAcceleration *)acceleration
{
	// どれくらい減速できるかを制御する
	// この値が小さいほど向きをすばやく変更できる
	float deceleration = 0.4f;
	// 加速度センサーの感度を決定する - この値が大きいほど感度が高くなる
	float sensitivity = 6.0f;
	// 最大速度
	float maxVelocity = 100;
	
	// 現在の加速度センサーの加速に基づいて速度を調整する
	playerVelocity.x = playerVelocity.x * deceleration +
	acceleration.x * sensitivity;
	
	// プレイヤースプライトの最大速度を両方向で制限しなければならない
	if (playerVelocity.x > maxVelocity)
	{
		playerVelocity.x = maxVelocity;
	}
	else if (playerVelocity.x < - maxVelocity)
	{
		playerVelocity.x = - maxVelocity;
	}
}

#pragma mark update

-(void) update:(ccTime)delta
{
	
	//フレームごとにplayerVelocityをプレイヤーの位置に追加する
	CGPoint pos = player.position;
	pos.x += playerVelocity.x;
	// プレイヤーを止めてスクリーンの外に出ないようにする必要もある
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [player texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
	
	// プレイヤースプライトがスクリーンの外で動かないようにする
	if (pos.x < leftBorderLimit)
	{
		pos.x = leftBorderLimit;
		playerVelocity = CGPointZero;
	}
	else if (pos.x > rightBorderLimit)
	{
		pos.x = rightBorderLimit;
		playerVelocity = CGPointZero;
	}
	
	// 変更した位置を割り当てる
	player.position = pos;
    [self checkForCollision];
	
	// スコア（タイマー）を１秒おきに更新する
	
	totalTime += delta;
	
	int currentTime = (int)totalTime;
	if (score < currentTime)
	{
		score = currentTime;
		[scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
	}
	if (totalTime >= 5)
	{
		spiderMoveDuration = 2.7f;
	}
	if (totalTime >= 10)
	{
		spiderMoveDuration = 2.5f;
	}
	if(totalTime >= 15)
	{
		spiderMoveDuration = 2.3f;
	}
	if(totalTime >= 20)
	{
		spiderMoveDuration = 2.0f;
	}
	if(totalTime >= 30)
	{
		spiderMoveDuration = 1.75f;
	}
	if(totalTime >= 50)
	{
		spiderMoveDuration = 1.5f;
	}
	if(totalTime >= 60)
	{
		spiderMoveDuration = 1.35f;
	}
	if(totalTime >= 70)
	{
		spiderMoveDuration = 1.2f;
	}
	if(totalTime >= 80)
	{
		spiderMoveDuration = 1.0f;
	}
	[hiscoreLabel setString:[NSString stringWithFormat:@"%i", hiscore]];
	
	if(imode == 2){
		//score = 0;
		//totalTime = 0;
		setumei.position = CGPointMake(1000, 1000);
	}
	if(imode == 3 || imode == 1 || imode == 4){
		
		spiderMoveDuration = 0.0f;
		score = 0;
		totalTime = 0;
	}
}


-(void) checkForCollision
{
	
	
	// プレイヤーとスパイダーの画像は正方形であると前提する
	float playerImageSize = [player texture].contentSize.width;
	float spiderImageSize = [[spiders lastObject] texture].contentSize.width;
	
	
	float playerCollisionRadius = playerImageSize * 0.4f;
	float spiderCollisionRadius = spiderImageSize * 0.4f;
	
	// この衝突距離は画像の形状にほぼ等しい
	float maxCollisionDistance = playerCollisionRadius
    + spiderCollisionRadius;
	
	
	int numSpiders = [spiders count];
	for (int i = 0; i < numSpiders; i++)
	{
		
		
		CCSprite* spider = [spiders objectAtIndex:i];
		if ([spider numberOfRunningActions] == 0)
		{
			// このスパイダーは動いていないのでチェックを省略する
			continue;
		}
		
		// プレイヤーとスパイダーの距離を所得する
		float actualDistance = ccpDistance(player.position, spider.position);
		if(spider.position.y == 1){
			[[SimpleAudioEngine sharedEngine] playEffect:@"kuruma.caf"];
		}
		
		// 2つのオブジェクトは接近しすぎているか
		if (actualDistance < maxCollisionDistance)
		{
			if(score >= hiscore)
			{
				hiscore = score;
				ome.position = CGPointMake(160, 305);
			}
			
			
			if(score <= 20){
				rank1.position = CGPointMake(160, 240);
			}
			else if(score >= 21 && score <=39)
			{
				rank2.position = CGPointMake(160, 240);
			}
			else if(score >= 40 && score <= 70)
			{
				rank3.position = CGPointMake(160, 240);
			}
			else if(score >= 71 && score <= 119)
			{
				rank4.position = CGPointMake(160, 240);
			}
			else if(score >= 120)
			{
				rank5.position = CGPointMake(160, 240);
			}
			
			// ゲームオーバーではなく、単にスパイダーをリセットする
			[self resetSpiders];
			score = 0;
			totalTime = 0;
			self.isTouchEnabled = YES;
			gameover.position = CGPointMake(160, 240);
			imode = 3;
			[[SimpleAudioEngine sharedEngine] playEffect:@"carcrash.caf"];
			
            
            
			
			NSLog(@"imode");
		}
        
	}
	
}
-(void) ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
    
	
	
	//score = 0;
	//totalTime = 0;
	//[self resetSpiders];
	//self.isTouchEnabled = NO;
	gameover.position = CGPointMake(1000, 1000);
	if(imode == 1){
		startgamen.position = CGPointMake(1000, 1000);
		setumei.position = CGPointMake(160, 240);
		imode = 4;
    }
	else if(imode == 3){
		gameover.position = CGPointMake(1000, 1000);
		startgamen.position = CGPointMake(160, 240);
		imode = 1;
		ome.position = CGPointMake(1000, 1000);
		rank1.position = CGPointMake(1000, 1000);
		rank2.position = CGPointMake(1000, 1000);
		rank3.position = CGPointMake(1000, 1000);
		rank4.position = CGPointMake(1000, 1000);
		rank5.position = CGPointMake(1000, 1000);
	}
	else if(imode == 4){
		setumei.position = CGPointMake(1000, 1000);
		imode = 2;
		score = 0;
		totalTime = 0;
		self.isTouchEnabled = NO;
        
        
	}
	
    
	
}
@end
