//
//  TMSettingViewController.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TMSettingViewControllerDelegate;

@interface TMSettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *holdSwitch;
- (IBAction)touchHoldSwtch:(id)sender;
- (IBAction)touchHoldStepper:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *touchHold;
- (IBAction)returnClick:(id)sender;
@property double touchHoldTime;
@property (nonatomic, assign) id<TMSettingViewControllerDelegate> delegate;
@property BOOL isEnable;
@end

@protocol TMSettingViewControllerDelegate <NSObject>
//protocolで定義するメソッド
-(void)settingViewController:(TMSettingViewController *)settingViewController didClose:(NSString *)message enable:(BOOL)enable;
@end
