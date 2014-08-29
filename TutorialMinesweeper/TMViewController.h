//
//  TMViewController.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMMainViewController.h"
@interface TMViewController : UIViewController
// メイン画面用ビュー
@property (nonatomic, weak) IBOutlet TMMainViewController *mainView;

// 難易度選択画面ボタンクリック用
- (IBAction)clickEasyButton:(id)sender;
- (IBAction)clickNormalButton:(id)sender;
- (IBAction)clickHardButton:(id)sender;

- (void)transitionToMinesweeperView:(int)difficulty;

@end
