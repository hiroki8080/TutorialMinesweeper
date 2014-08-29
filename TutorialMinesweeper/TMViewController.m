//
//  TMViewController.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMViewController.h"
#import "TMMainViewController.h"
#import "TMLogic.h"

@interface TMViewController ()

@end

@implementation TMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 難易度選択：Easyクリック時の処理
- (IBAction)clickEasyButton:(id)sender {
    [self transitionToMinesweeperView:MODE_EASY];
}

// 難易度選択：Normalクリック時の処理
- (IBAction)clickNormalButton:(id)sender {
    [self transitionToMinesweeperView:MODE_NORMAL];
}

// 難易度選択：Hardクリック時の処理
- (IBAction)clickHardButton:(id)sender {
    [self transitionToMinesweeperView:MODE_HARD];
}

- (void)transitionToMinesweeperView:(int)difficulty{
    // メイン画面表示
    TMMainViewController *minesweeperView = [self.storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    minesweeperView.minesweeper = [[TMLogic new] initWithDifficulty:difficulty];
    self.mainView = minesweeperView;
    
    [self presentViewController:self.mainView animated:YES completion:nil];
}

@end
