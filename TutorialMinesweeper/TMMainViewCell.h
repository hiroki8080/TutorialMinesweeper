//
//  TMMainViewCell.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMLogic.h"
@interface TMMainViewCell : UICollectionViewCell
@property (nonatomic, retain) IBOutlet UIImage *nowViewPlate;
@property (nonatomic, retain) IBOutlet UIImage *plate;
@property (nonatomic, retain) IBOutlet UIImage *plate1;
@property (nonatomic, retain) IBOutlet UIImage *plate2;
@property (nonatomic, retain) IBOutlet UIImage *plate3;
@property (nonatomic, retain) IBOutlet UIImage *plate4;
@property (nonatomic, retain) IBOutlet UIImage *plate5;
@property (nonatomic, retain) IBOutlet UIImage *plate6;
@property (nonatomic, retain) IBOutlet UIImage *plate7;
@property (nonatomic, retain) IBOutlet UIImage *plate8;
@property (nonatomic, retain) IBOutlet UIImage *nonPlate;
@property (nonatomic, retain) IBOutlet UIImage *bombPlate;
@property (nonatomic, retain) IBOutlet UIImage *flag;
@property (nonatomic, retain) IBOutlet UIImage *question;
@property (nonatomic, retain) IBOutlet UIImage *explosion;
@property (nonatomic) int viewStatus;
@property (nonatomic) bool isBomb;
@property (nonatomic) bool isExplosion;
@property (nonatomic) bool isFlag;
@property (nonatomic) bool isQuestion;
@property (nonatomic) int bomCount;
@property float sizeX;
@property float sizeY;
-(void)tapToChangeBackGround;
-(UIImage*)createImage:(NSString*)path;
-(void)initProperty;
-(void)setExpansion;
-(void)resetExpansion;
@end
