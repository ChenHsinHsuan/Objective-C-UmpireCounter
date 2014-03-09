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
@interface CounterTabBarViewController ()<UITabBarControllerDelegate>
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





@end
