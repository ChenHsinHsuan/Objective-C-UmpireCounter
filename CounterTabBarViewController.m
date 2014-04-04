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
#import "GameListViewController.h"
#import "GameDetailViewController.h"
#import "ScoreBoxCell.h"
#import "Inning.h"
@interface CounterTabBarViewController ()<UITabBarControllerDelegate, UIActionSheetDelegate>
@end

@implementation CounterTabBarViewController

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
        
        int totalGuestScore = 0;
        int totalHomeScore = 0;
        for (Inning *theInning in self.game.inningDetail){
            totalGuestScore += [theInning.guestScore intValue];
            totalHomeScore += [theInning.homeScore intValue];
        }
        self.game.homeScore = [NSString stringWithFormat:@"%d", totalHomeScore];
        self.game.guestScore =[NSString stringWithFormat:@"%d", totalGuestScore];
        self.game.completed = [NSNumber numberWithBool:YES];
        self.game.endTm = [NSDate new];
        
//        GameListViewController *theGameListVC = (GameListViewController *) self.navigationController.presentedViewController.presentedViewController;
//        [theGameListVC saveGame];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
