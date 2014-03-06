//
//  AddGameViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/5.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "AddGameViewController.h"
#import "GameListViewController.h"

@interface AddGameViewController ()<UIPickerViewDelegate, UIPickerViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *ballTypeSegmentedControls;
@property (strong, nonatomic) IBOutlet UITextField *guestTeamNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *homeTeamNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *fieldNameTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *inningAndTimePickerView;
@property (strong, nonatomic) IBOutlet UIButton *createGameButton;

@property NSArray *inningArr;
@property NSArray *gameTimeArr;

@end

@implementation AddGameViewController

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SettingParameter" ofType:@"plist"];
    NSDictionary *settingDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.inningArr = [[NSArray alloc] initWithArray:[settingDict objectForKey:@"inning"]];
    self.gameTimeArr = [[NSArray alloc] initWithArray:[settingDict objectForKey:@"gameTime"]];
    
    
    self.inningAndTimePickerView = [[UIPickerView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createGameButtonPressed:(id)sender {
    NSMutableString *errMsg = [[NSMutableString alloc]init];
    
    if (self.guestTeamNameTextField.text.length == 0 ) {
        [errMsg appendString: @"請輸入先攻球隊名稱\n"];
    }
    if (self.homeTeamNameTextField.text.length == 0) {
        [errMsg appendString: @"請輸入後攻球隊名稱"];
    }
    
    if (self.fieldNameTextField.text.length == 0) {
        [self.fieldNameTextField setText:@"某某球場"];
    }
    if(errMsg.length > 0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:errMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"確認", nil];
        [alertView show];
        return;
    }
    
    
    
}


#pragma -segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.createGameButton) {
        return;
    }
    
        
    if (self.guestTeamNameTextField.text.length > 0 && self.homeTeamNameTextField.text.length > 0) {
        self.game = [[Game alloc] init];
        self.game.ball_type = [self.ballTypeSegmentedControls titleForSegmentAtIndex:self.ballTypeSegmentedControls.selectedSegmentIndex];
        self.game.guest_team_name = self.guestTeamNameTextField.text;
        self.game.home_team_name = self.homeTeamNameTextField.text;
        self.game.fieldName = self.fieldNameTextField.text;
        self.game.inning = self.inningArr[[self.inningAndTimePickerView selectedRowInComponent:0]];
        self.game.game_time = self.gameTimeArr[[self.inningAndTimePickerView selectedRowInComponent:1]];
        self.game.completed = NO;
    }
}

#pragma  -PickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.inningArr.count;
    }else{
        return self.gameTimeArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.inningArr[row];
    }else{
        return self.gameTimeArr[row];
    }
}

#pragma -textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
