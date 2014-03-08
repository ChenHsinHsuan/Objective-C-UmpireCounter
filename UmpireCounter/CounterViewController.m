//
//  CounterViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "CounterViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface CounterViewController ()
@property (strong, nonatomic) IBOutlet UIButton *B1;
@property (strong, nonatomic) IBOutlet UIButton *B2;
@property (strong, nonatomic) IBOutlet UIButton *B3;
@property (strong, nonatomic) IBOutlet UIButton *S1;
@property (strong, nonatomic) IBOutlet UIButton *S2;
@property (strong, nonatomic) IBOutlet UIButton *O1;
@property (strong, nonatomic) IBOutlet UIButton *O2;
@property (strong, nonatomic) IBOutlet UILabel *scoreTextField;
@property (strong, nonatomic) IBOutlet UILabel *attackingTeamNameTextField;
@property (strong, nonatomic) IBOutlet UIStepper *scoreStepper;

@property int bCount;
@property int sCount;
@property int oCount;
@property int scoreCount;
@property int inning;
@property NSString *inningKd;
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
    self.game = self.tabBarController.game;
    if([self.game.ball_type isEqualToString: @"棒球"]){
        self.bCount = 0;
        self.sCount = 0;
    }else{
        self.bCount = 1;
        self.sCount = 1;
    }
    self.oCount = 0;
    self.scoreCount = 0;
    self.inning = 1;
    self.inningKd = @"U";//U:上半局  D:下半局
    self.scoreTextField.text = [NSString stringWithFormat:@"%d", self.scoreCount];

    [self refreshInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshInfo
{
    if([self.inningKd isEqualToString:@"U"]){
        self.navigationItem.title = [NSString stringWithFormat:@"%d上", self.inning];
        self.attackingTeamNameTextField.text = self.game.guest_team_name;
    }else{
        self.navigationItem.title = [NSString stringWithFormat:@"%d下", self.inning];
        self.attackingTeamNameTextField.text = self.game.home_team_name;
    }
    
    
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
        self.bCount = 0;
        if([self.game.ball_type isEqualToString: @"棒球"]){
            self.sCount = 0;
        }else{
            self.sCount = 1;
        }
    }
    [self refreshLight];
}
- (void) doSCount
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.sCount++;
    if( self.sCount > 2){
        self.sCount = 0;
        if([self.game.ball_type isEqualToString: @"棒球"]){
            self.bCount = 0;
        }else{
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
        //換局
    }
    [self refreshLight];
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
    self.scoreTextField.text = [NSString stringWithFormat:@"%d", self.scoreCount];
}

@end
