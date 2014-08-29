//
//  TMHeaderView.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMMainHeaderView : UIToolbar
@property (strong, nonatomic) IBOutlet UIButton *endButton;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (nonatomic, retain) IBOutlet UIImage *timerImage;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain) IBOutlet UIImage *bombCountImage;
@property (strong, nonatomic) IBOutlet UILabel *bombCountLabel;
@property (nonatomic, retain) IBOutlet UIImage *pinchInImage;
@property (nonatomic, retain) IBOutlet UIImage *pinchOutImage;
@property (strong, nonatomic) IBOutlet UIButton *pinchiInButton;
@property (strong, nonatomic) IBOutlet UIButton *pinchiOutButton;
@property (strong, nonatomic) IBOutlet UIButton *configButton;

@end
