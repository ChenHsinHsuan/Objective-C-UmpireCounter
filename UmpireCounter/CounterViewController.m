//
//  CounterViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "CounterViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Inning.h"
@interface CounterViewController ()<UIAlertViewDelegate>
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

@property int bCount;
@property int sCount;
@property int oCount;
@property int scoreCount;
@property int inning;
@property BOOL inningKd;
@end

@implementation CounterViewController

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
    [self initLightAndScore];
    self.inning = 1;
    self.inningKd = NO;//NO:上半局  YES:下半局

    if(self.game.inningArr == nil){
        self.game.inningArr = [[NSMutableArray alloc]init];
        Inning *inning = [[Inning alloc]init];
        inning.inning = self.inning;
        [self.game.inningArr addObject:inning];
    }
    
    [self refreshInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initLightAndScore
{
    if([self.game.ball_type isEqualToString: @"棒球"]){
        self.bCount = 0;
        self.sCount = 0;
    }else{
        self.bCount = 1;
        self.sCount = 1;
    }
    self.oCount = 0;
    self.scoreCount = 0;
}

- (void) refreshInfo
{
    if(!self.inningKd){
        self.tabBarController.navigationItem.title = [NSString stringWithFormat:@"%d局上", self.inning];
        self.attackingTeamNameLabel.text = self.game.guest_team_name;
    }else{
        self.tabBarController.navigationItem.title = [NSString stringWithFormat:@"%d局下", self.inning];
        self.attackingTeamNameLabel.text = self.game.home_team_name;
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
        if([self.game.ball_type isEqualToString: @"棒球"]){
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
        if([self.game.ball_type isEqualToString: @"棒球"]){
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
        if([self.game.ball_type isEqualToString: @"棒球"]){
            self.bCount = 0;
            self.sCount = 0;
        }else{
            self.bCount = 1;
            self.sCount = 1;
        }
        self.oCount = 0;

        [self alertChangeInning];
    }
    [self refreshLight];
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
    //記錄每局的得分狀況
    Inning *inning = self.game.inningArr[self.inning-1];
    
    if(!self.inningKd){
        //上半局
        inning.guestScore = self.scoreCount;
    }else{
        //下半局
        inning.homeScore = self.scoreCount;
    }

    //換局設定
    self.inningKd = !self.inningKd;
    if(!self.inningKd){
       self.inning++;
        
        if(self.game.inningArr.count != self.inning){
            inning = [[Inning alloc]init];
            inning.inning = self.inning;
            [self.game.inningArr addObject:inning];
        }
    }

    
    [self initLightAndScore];
    [self refreshInfo];
}


#pragma -UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex == 1){
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
    
    Inning *inning = self.game.inningArr[self.inning-1];
    if(!self.inningKd){
        inning.guestScore = self.scoreCount;
    }else{
        inning.homeScore = self.scoreCount;
    }
}

@end
