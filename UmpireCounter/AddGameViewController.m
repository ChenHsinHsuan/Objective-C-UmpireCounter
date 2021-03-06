//
//  AddGameViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/5.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "AddGameViewController.h"
#import "AppDelegate.h"
@interface AddGameViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SettingParameter" ofType:@"plist"];
    NSDictionary *settingDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.inningArr = [[NSArray alloc] initWithArray:[settingDict objectForKey:@"inning"]];
    self.gameTimeArr = [[NSArray alloc] initWithArray:[settingDict objectForKey:@"gameTime"]];
    
    [self.inningAndTimePickerView selectRow:8 inComponent:0 animated:YES];
    [self.inningAndTimePickerView selectRow:9 inComponent:1 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.navigationItem.leftBarButtonItem) {
        return;
    }
    
    
    if(self.guestTeamNameTextField.text.length == 0){
        self.guestTeamNameTextField.text = @"先攻";
    }
    
    if (self.homeTeamNameTextField.text.length == 0) {
        self.homeTeamNameTextField.text = @"後攻";
    }
    
    if (self.fieldNameTextField.text.length == 0) {
        self.fieldNameTextField.text = @"某某球場";
    }
        

    self.game.ballType = [self.ballTypeSegmentedControls titleForSegmentAtIndex:self.ballTypeSegmentedControls.selectedSegmentIndex];
    self.game.guestName = self.guestTeamNameTextField.text;
    self.game.homeName = self.homeTeamNameTextField.text;
    self.game.fieldName = self.fieldNameTextField.text;
    self.game.gfTm = [NSDate date];
    self.game.inningSet = self.inningArr[[self.inningAndTimePickerView selectedRowInComponent:0]];
    self.game.timeSet = self.gameTimeArr[[self.inningAndTimePickerView selectedRowInComponent:1]];
    self.game.completed = [NSNumber numberWithBool:NO];
    
}

#pragma -segment control
- (IBAction)ballTypeChange:(id)sender {
    if(self.ballTypeSegmentedControls.selectedSegmentIndex == 0){
        //棒球
        [self.inningAndTimePickerView selectRow:8 inComponent:0 animated:YES];
        [self.inningAndTimePickerView selectRow:9 inComponent:1 animated:YES];
    }else{
        //壘球
        [self.inningAndTimePickerView selectRow:6 inComponent:0 animated:YES];
        [self.inningAndTimePickerView selectRow:3 inComponent:1 animated:YES];
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
