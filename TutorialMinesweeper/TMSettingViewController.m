//
//  TMSettingViewController.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMSettingViewController.h"

@interface TMSettingViewController ()

@end

@implementation TMSettingViewController
@synthesize touchHoldTime;
@synthesize delegate;
@synthesize isEnable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.touchHold.text = [NSString stringWithFormat:@"%.1f", self.touchHoldTime];
    if(self.isEnable){
        self.holdSwitch.on=YES;
    }else{
        self.holdSwitch.on=NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchHoldSwtch:(id)sender {
    UISwitch *s = (UISwitch*)sender;
    if(s.on){
        self.isEnable=true;
    }else{
        self.isEnable=false;
    }
}

- (IBAction)touchHoldStepper:(id)sender {
    UIStepper *steppr = (UIStepper*)sender;
    self.touchHold.text = [NSString stringWithFormat: @"%.1f" ,steppr.value];
}
- (IBAction)returnClick:(id)sender {
    [delegate settingViewController:self didClose:self.touchHold.text enable:self.isEnable];
}


@end
