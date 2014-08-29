//
//  TMMainViewController.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMLogic.h"
#import "TMMainViewCell.h"
#import "TMMainHeaderView.h"
#import "TMMainViewLayout.h"
#import "TMSettingViewController.h"

@interface TMMainViewController : UICollectionViewController<TMSettingViewControllerDelegate>
@property (nonatomic, retain) IBOutlet TMMainHeaderView *header;
@property TMLogic *minesweeper;
@property float cellSizeX;
@property float cellSizeY;
@property BOOL isLongTap;
@property BOOL isGameStarted;
@property int magnification;
@property NSTimer *timer;
@property int time;
@property UILongPressGestureRecognizer *longPressGesture;
@property BOOL isScrolling;
@property NSMutableDictionary *cellCache;
@end
