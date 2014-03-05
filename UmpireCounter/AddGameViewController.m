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
@property (strong, nonatomic) IBOutlet UISegmentedControl *gameTypeSegmentedControls;
@property (strong, nonatomic) IBOutlet UITextField *guestTeamNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *homeTeamNameTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *inningAndTimePickerView;
@property NSArray *inningArr;
@property NSArray *gameTimeArr;
@property (strong, nonatomic) IBOutlet UIButton *createGameButton;

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
    self.inningArr = @[@"3局", @"4局", @"5局", @"6局", @"7局", @"8局", @"9局"];
    self.gameTimeArr = @[@"30分鐘", @"40分鐘", @"50分鐘", @"60分鐘", @"70分鐘", @"80分鐘", @"90分鐘"];
    
    self.inningAndTimePickerView = [[UIPickerView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.createGameButton) {
        return;
    }
    if (self.guestTeamNameTextField.text.length > 0 && self.homeTeamNameTextField.text.length > 0) {
        self.game = [[Game alloc] init];
        self.game.guestTeamName = self.guestTeamNameTextField.text;
        self.game.homeTeamName = self.homeTeamNameTextField.text;
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
