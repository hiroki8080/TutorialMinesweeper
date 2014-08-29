//
//  TMMainViewCell.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMMainViewCell.h"

@implementation TMMainViewCell
@synthesize nowViewPlate;
@synthesize plate;
@synthesize plate1;
@synthesize plate2;
@synthesize plate3;
@synthesize plate4;
@synthesize plate5;
@synthesize plate6;
@synthesize plate7;
@synthesize plate8;
@synthesize nonPlate;
@synthesize bombPlate;
@synthesize flag;
@synthesize question;
@synthesize explosion;
@synthesize viewStatus;
@synthesize isBomb;
@synthesize isExplosion;
@synthesize isFlag;
@synthesize isQuestion;
@synthesize bomCount;
@synthesize sizeX;
@synthesize sizeY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initProperty];
    }
    return self;
}


- (void)initProperty{
    self.plate = [self createImage:@"plate.png"];
    self.nowViewPlate = self.plate;
    self.plate1 = [self createImage:@"plate1.png"];
    self.plate2 = [self createImage:@"plate2.png"];
    self.plate3 = [self createImage:@"plate3.png"];
    self.plate4 = [self createImage:@"plate4.png"];
    self.plate5 = [self createImage:@"plate5.png"];
    self.plate6 = [self createImage:@"plate6.png"];
    self.plate7 = [self createImage:@"plate7.png"];
    self.plate8 = [self createImage:@"plate8.png"];
    self.flag = [self createImage:@"flag.png"];
    self.question = [self createImage:@"question.png"];
    self.explosion = [self createImage:@"explosion.png"];
    self.nonPlate = [self createImage:@"nonplate.png"];
    self.bombPlate = [self createImage:@"bomb.png"];
    self.viewStatus = CLOSED;
    self.isBomb = false;
    self.isFlag = false;
    self.isQuestion = false;
    self.isExplosion = false;
    self.bomCount = 0;
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
    affine.ty = self.sizeY;
    CGContextConcatCTM(context, affine);
    CGContextDrawImage(context, CGRectMake(0, 0, self.sizeX, self.sizeY), self.nowViewPlate.CGImage);
}

-(void)setExpansion{
    self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    [self setNeedsDisplay];
}
-(void)resetExpansion{
    self.transform = CGAffineTransformIdentity;
    [self setNeedsDisplay];
}


// セルがタップされた場合の処理
-(void)tapToChangeBackGround{
    if (self.viewStatus==CLOSED) {
        if (self.isFlag) {
            self.nowViewPlate = self.flag;
        }else if(self.isQuestion){
            self.nowViewPlate = self.question;
        }else {
            self.nowViewPlate = self.plate;
        }
    }
    else{
        if(self.isExplosion){
            self.nowViewPlate = self.explosion;
        } else if (self.isBomb) {
            self.nowViewPlate = self.bombPlate;
        }else{
            switch (bomCount) {
                case 0:
                    self.nowViewPlate = self.nonPlate;
                    break;
                case 1:
                    self.nowViewPlate = self.plate1;
                    break;
                case 2:
                    self.nowViewPlate = self.plate2;
                    break;
                case 3:
                    self.nowViewPlate = self.plate3;
                    break;
                case 4:
                    self.nowViewPlate = self.plate4;
                    break;
                case 5:
                    self.nowViewPlate = self.plate5;
                    break;
                case 6:
                    self.nowViewPlate = self.plate6;
                    break;
                case 7:
                    self.nowViewPlate = self.plate7;
                    break;
                case 8:
                    self.nowViewPlate = self.plate8;
                    break;
                default:
                    break;
            }
        }
    }
    // セルの再描画
    [self setNeedsDisplay];
}

// セル用のイメージ生成処理
-(UIImage*)createImage:(NSString*)path
{
    UIImage* image = [UIImage imageNamed:path];
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationRight];
}

@end
