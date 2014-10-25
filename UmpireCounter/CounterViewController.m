//
//  CounterViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "CounterViewController.h"
#import "Inning.h"
#import "MyTimer.h"
#import "GameListViewController.h"
@interface CounterViewController ()
@property (strong, nonatomic) IBOutlet UIButton *B1;
@property (strong, nonatomic) IBOutlet UIButton *B2;
@property (strong, nonatomic) IBOutlet UIButton *B3;
@property (strong, nonatomic) IBOutlet UIButton *S1;
@property (strong, nonatomic) IBOutlet UIButton *S2;
@property (strong, nonatomic) IBOutlet UIButton *O1;
@property (strong, nonatomic) IBOutlet UIButton *O2;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *attackingTeamNameLabel;
@property (strong, nonatomic) IBOutlet UIStepper *scoreStepper;
@property (strong, nonatomic) IBOutlet UILabel *InningLabel;


@property Inning *nowInning;
@property int bCount;
@property int sCount;
@property int oCount;
@property int scoreCount;
@property int inning;
@property BOOL inningKd;
@end

@implementation CounterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Make self the delegate of the ad banner.
    self.adBanner.delegate = self;
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0;

    MyTimer *timer = [[MyTimer alloc]init];
    [timer initTimerStartCountFrom:self.game.timeSet
              WithTabBarController:self.tabBarController];
    
    [self initLightAndScore];
    self.inning = 1;
    self.inningKd = NO;//NO:上半局  YES:下半局
    
    if(self.game.inningDetail == nil || self.game.inningDetail.count == 0){
        NSManagedObjectContext *context = [self.game managedObjectContext];
         Inning *inning = (Inning *)[NSEntityDescription insertNewObjectForEntityForName:@"Inning" inManagedObjectContext:context];
        inning.sn = [NSString stringWithFormat:@"%d", self.inning ];
        [self.game addInningDetailObject:inning];
    
        _nowInning = inning;
    }
    [self refreshInfo];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initLightAndScore
{
    [self initLight];
    self.scoreCount = 0;
}

- (void) initLight
{
    if([self.game.ballType isEqualToString: @"棒球"]){
        self.bCount = 0;
        self.sCount = 0;
    }else{
        self.bCount = 1;
        self.sCount = 1;
    }
    self.oCount = 0;
}

- (void) refreshInfo
{
    if(!self.inningKd){
        self.InningLabel.text = [NSString stringWithFormat:@"%d局上", self.inning];
        self.attackingTeamNameLabel.text = self.game.guestName;
    }else{
        self.InningLabel.text = [NSString stringWithFormat:@"%d局下", self.inning];
        self.attackingTeamNameLabel.text = self.game.homeName;
    }
    
    self.scoreStepper.value = self.scoreCount;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.scoreCount];
    [self refreshLight];
}


- (void) refreshLight
{
    
//    NSLog(@"B:%d,S:%d,O:%d", self.bCount, self.sCount, self.oCount);
    switch (self.bCount) {
        case 0:
            [self.B1 setSelected:NO];
            [self.B2 setSelected:NO];
            [self.B3 setSelected:NO];
            break;
        case 1:
            [self.B1 setSelected:YES];
            [self.B2 setSelected:NO];
            [self.B3 setSelected:NO];
            break;
        case 2:
            [self.B1 setSelected:YES];
            [self.B2 setSelected:YES];
            [self.B3 setSelected:NO];
            break;
        case 3:
            [self.B1 setSelected:YES];
            [self.B2 setSelected:YES];
            [self.B3 setSelected:YES];
            break;
        default:
            break;
    }
    
    switch (self.sCount) {
        case 0:
            [self.S1 setSelected:NO];
            [self.S2 setSelected:NO];
            break;
        case 1:
            [self.S1 setSelected:YES];
            [self.S2 setSelected:NO];
            break;
        case 2:
            [self.S1 setSelected:YES];
            [self.S2 setSelected:YES];
            break;
        default:
            break;
    }
    
    switch (self.oCount) {
        case 0:
            [self.O1 setSelected:NO];
            [self.O2 setSelected:NO];
            break;
        case 1:
            [self.O1 setSelected:YES];
            [self.O2 setSelected:NO];
            break;
        case 2:
            [self.O1 setSelected:YES];
            [self.O2 setSelected:YES];
            break;
        default:
            break;
    }
}
- (void) doBCount
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.bCount++;
    if(self.bCount > 3 ){
        if([self.game.ballType isEqualToString: @"棒球"]){
            self.sCount = 0;
            self.bCount = 0;
        }else{
            self.sCount = 1;
            self.bCount = 1;
        }
    }
    [self refreshLight];
}
- (void) doSCount
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.sCount++;
    if( self.sCount > 2){
        if([self.game.ballType isEqualToString: @"棒球"]){
            self.sCount = 0;
            self.bCount = 0;
        }else{
            self.sCount = 1;
            self.bCount = 1;
        }
        [self doOCount];
    }
    [self refreshLight];
}
- (void) doOCount
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.oCount++;
    if(self.oCount > 2){
        if([self.game.ballType isEqualToString: @"棒球"]){
            self.bCount = 0;
            self.sCount = 0;
        }else{
            self.bCount = 1;
            self.sCount = 1;
        }
        self.oCount = 0;
        
        
        int totalGuestScore = 0;
        int totalHomeScore = 0;
        for (Inning *theInning in self.game.inningDetail){
            totalGuestScore += [theInning.guestScore intValue];
            totalHomeScore += [theInning.homeScore intValue];
        }

        
        if(self.inning == [self.game.inningSet intValue]){
            //比賽設定的局數已經到了
            if (!self.inningKd) {
                //上半局結束準備換下半局
                if(totalHomeScore > totalGuestScore){
                    //主場球隊獲勝，結束比賽
                    [self alertGameSetAndHomeScroe:totalHomeScore GuestScore:totalGuestScore];
                }else{
                    [self alertChangeInning];
                }
            }else{
                //下半局結束
                [self alertGameSetAndHomeScroe:totalHomeScore GuestScore:totalGuestScore];
            }
            
        }else{
            [self alertChangeInning];
        }
    }
    [self refreshLight];
}

- (void)alertGameSetAndHomeScroe:(int) iHomeScore GuestScore: (int) iGuestScore
{
    
    
    self.game.homeScore = [NSString stringWithFormat:@"%d", iHomeScore];
    self.game.guestScore =[NSString stringWithFormat:@"%d", iGuestScore];
    self.game.completed = [NSNumber numberWithBool:YES];
    self.game.endTm = [NSDate new];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@ vs %@", self.game.guestName, self.game.homeName]
                                                       message:[NSString stringWithFormat:@"%d - %d", iGuestScore, iHomeScore]
                                                      delegate:self
                                             cancelButtonTitle:@"結束比賽"
                                             otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertChangeInning
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"換局"
                                                    message:@""
                                                    delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"攻守交替", nil];
    [alertView show];
}

- (void)changeInning
{

    if(!self.inningKd){
        //上半局
        _nowInning.guestScore = [NSString stringWithFormat:@"%d", self.scoreCount];
    }else{
        //下半局
        _nowInning.homeScore = [NSString stringWithFormat:@"%d", self.scoreCount];
    }

    //換局設定
    self.inningKd = !self.inningKd;
    if(!self.inningKd){
       self.inning++;
        
        if(self.game.inningDetail.count != self.inning){
            NSManagedObjectContext *context = [self.game managedObjectContext];
            Inning *inning = (Inning *)[NSEntityDescription insertNewObjectForEntityForName:@"Inning" inManagedObjectContext:context];
            inning.sn = [NSString stringWithFormat:@"%d", self.inning ];
            [self.game addInningDetailObject:inning];
            _nowInning = inning;
        }
    }

    
    [self initLightAndScore];
    [self refreshInfo];
}


#pragma -UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if ([alertView.title isEqual:[NSString stringWithFormat:@"%@ vs %@", self.game.guestName, self.game.homeName]] && buttonIndex == 0) {
        //比賽結束的做法
//        GameListViewController *theGameListVC = (GameListViewController *) self.tabBarController.navigationController.presentedViewController.presentedViewController;
//        [theGameListVC saveGame];
        [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if(buttonIndex == 1){
        //換局
        [self changeInning];
    }
}
#pragma -button

- (IBAction)B1ButtonPressed:(id)sender {
    [self doBCount];
}
- (IBAction)B2ButtonPressed:(id)sender {
    [self doBCount];
}
- (IBAction)B3ButtonPressed:(id)sender {
    [self doBCount];
}
- (IBAction)S1ButtonPressed:(id)sender {
    [self doSCount];
}
- (IBAction)S2ButtonPressed:(id)sender {
    [self doSCount];
}
- (IBAction)O1ButtonPressed:(id)sender {
    [self doOCount];
}
- (IBAction)O2ButtonPressed:(id)sender {
    [self doOCount];
}
- (IBAction)stepperPressed:(UIStepper *)sender {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.scoreCount = sender.value;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.scoreCount];

    if(!self.inningKd){
        _nowInning.guestScore = [NSString stringWithFormat:@"%d", self.scoreCount];
    }else{
        _nowInning.homeScore = [NSString stringWithFormat:@"%d", self.scoreCount];
    }
    
    //最後半局得分就結束比賽
    if(self.inning == [self.game.inningSet intValue]  && self.inningKd){
        int totalGuestScore = 0;
        int totalHomeScore = 0;
        for (Inning *theInning in self.game.inningDetail){
            totalGuestScore += [theInning.guestScore intValue];
            totalHomeScore += [theInning.homeScore intValue];
        }
        
        if (totalHomeScore > totalGuestScore) {
            [self alertGameSetAndHomeScroe:totalHomeScore GuestScore:totalGuestScore];
        }
    }
}
- (IBAction)hitsButtonPressed:(id)sender {
    if([self.game.ballType isEqualToString: @"棒球"]){
        self.bCount = 0;
        self.sCount = 0;
    }else{
        self.bCount = 1;
        self.sCount = 1;
    }
    [self refreshLight];
}


#pragma adbanner

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
    
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}

@end
