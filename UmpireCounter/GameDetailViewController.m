//
//  GameDetailViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "GameDetailViewController.h"
#import "CounterTabBarViewController.h"
@interface GameDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *ballTypeImageView;
@property (strong, nonatomic) IBOutlet UILabel *ballTypeTextField;
@property (strong, nonatomic) IBOutlet UILabel *gameTimeTextField;
@property (strong, nonatomic) IBOutlet UILabel *inningSetTextField;
@property (strong, nonatomic) IBOutlet UILabel *fieldNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamTextField;
@property (strong, nonatomic) IBOutlet UILabel *guestTeamTextField;
@end

@implementation GameDetailViewController

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
    _ballTypeTextField.text = self.game.ballType;
    _gameTimeTextField.text = self.game.timeSet;
    _inningSetTextField.text = self.game.inningSet;
    _fieldNameTextField.text = self.game.fieldName;
    _homeTeamTextField.text = self.game.homeName;
    _guestTeamTextField.text = self.game.guestName;
    
    if([self.game.ballType isEqual:@"棒球"]){
        [_ballTypeImageView setImage:[UIImage imageNamed:@"baseball.png"]];
    }else{
        [_ballTypeImageView setImage:[UIImage imageNamed:@"softball.png"]];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"playBall" sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"playBall"]){
        CounterTabBarViewController *destVC = [segue destinationViewController];
        destVC.game = self.game;
    }
}



@end
