//
//  CounterTabBarViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "CounterTabBarViewController.h"
#import "CounterViewController.h"
#import "ScoreBoxViewController.h"
#import "ScoreBoxCell.h"
#import "Inning.h"
@interface CounterTabBarViewController ()<UITabBarControllerDelegate, UIActionSheetDelegate>
@end

@implementation CounterTabBarViewController

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
    CounterViewController *counterVC= [[self viewControllers] objectAtIndex:0];
    counterVC.game = self.game;
    
    ScoreBoxViewController *scoreBoxVC =[[self viewControllers] objectAtIndex:1];
    scoreBoxVC.game = self.game;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"繼續"
                                               destructiveButtonTitle:@"結束比賽"
                                                    otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //結束比賽
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
