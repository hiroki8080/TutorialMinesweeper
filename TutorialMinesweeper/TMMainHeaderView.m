//
//  TMHeaderView.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMMainHeaderView.h"

@implementation TMMainHeaderView
@synthesize endButton;
@synthesize resetButton;
@synthesize timerImage;
@synthesize timerLabel;
@synthesize bombCountImage;
@synthesize bombCountLabel;
@synthesize pinchiInButton;
@synthesize pinchiOutButton;
@synthesize pinchInImage;
@synthesize pinchOutImage;
@synthesize configButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blueColor]];
        
        endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        endButton.frame = CGRectMake(0, 30, 40, 30);
        [endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [endButton setTitle:@"End" forState:UIControlStateNormal];
        [self addSubview:endButton];
        
        resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resetButton.frame = CGRectMake(40, 30, 40, 30);
        [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [resetButton setTitle:@"New" forState:UIControlStateNormal];
        [self addSubview:resetButton];
        
        bombCountLabel =  [[UILabel alloc] initWithFrame:CGRectMake(110,30,40,30)];
        bombCountLabel.text = @"0";
        bombCountLabel.textColor = [UIColor whiteColor];
        bombCountLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:bombCountLabel];
        
        timerLabel =  [[UILabel alloc] initWithFrame:CGRectMake(170,30,40,30)];
        timerLabel.text = @"0";
        timerLabel.textColor = [UIColor whiteColor];
        timerLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:timerLabel];
        
        self.bombCountImage = [self createImage:@"bombCount.png"];
        self.timerImage = [self createImage:@"timerCount.png"];
        
        self.pinchOutImage = [UIImage imageNamed:@"pinchOut.png"];
        pinchiOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pinchiOutButton.frame = CGRectMake(200, 35, 20, 20);
        [pinchiOutButton setBackgroundImage:self.pinchOutImage forState:UIControlStateNormal];
        [self addSubview:pinchiOutButton];
        
        
        self.pinchInImage = [UIImage imageNamed:@"pinchIn.png"];
        pinchiInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pinchiInButton.frame = CGRectMake(220, 35, 20, 20);
        [pinchiInButton setBackgroundImage:self.pinchInImage forState:UIControlStateNormal];
        [self addSubview:pinchiInButton];
        
        configButton = [UIButton buttonWithType:UIButtonTypeCustom];
        configButton.frame = CGRectMake(250, 35, 55, 20);
        [configButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [configButton setTitle:@"Config" forState:UIControlStateNormal];
        [self addSubview:configButton];
        
    }
    return self;
}

-(void)reDraw{
    [self.endButton setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 標準ではCGContextDrawが上下に描画されるため、設定を変更
    CGAffineTransform affine = CGAffineTransformIdentity;
    affine.d = -1.0f;
    affine.ty = 10.0f;
    CGContextConcatCTM(context, affine);
    CGContextDrawImage(context, CGRectMake(90, -45, 20, 20), self.bombCountImage.CGImage);
    CGContextDrawImage(context, CGRectMake(150, -45, 20, 20), self.timerImage.CGImage);
}

// ヘッダー用のイメージ生成処理
-(UIImage*)createImage:(NSString*)path
{
    UIImage* image = [UIImage imageNamed:path];
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationRight];
}


@end
