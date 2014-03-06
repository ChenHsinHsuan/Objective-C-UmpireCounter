//
//  GameListViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/5.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "GameListViewController.h"
#import "Game.h"
#import "GameTableViewCell.h"
#import "AddGameViewController.h"
@interface GameListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *gameArr;


@property (strong, nonatomic) IBOutlet UITableView *gameListTableView;
@end

@implementation GameListViewController

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
    self.gameArr = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)unwindToGameList:(UIStoryboardSegue *)segue
{
    AddGameViewController *source = [segue sourceViewController];
    Game *game = source.game;
    if (game != nil) {
        [self.gameArr addObject:game];
        [self.gameListTableView reloadData];
    }
}



#pragma -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //製作可重復利用的表格欄位Cell
    static NSString *CellIdentifier = @"GameCell";
    
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //設定欄位的內容與類型
    Game *game = [self.gameArr objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = game.guest_team_name;
//    if (game.completed) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }

    cell.guestTeamNameTextField.text =  game.guest_team_name;
    cell.guestScoreTextField.text = [game.guest_score stringValue];
    cell.homeTeamNameTextField.text = game.home_team_name;
    cell.homeScoreTextField.text = [game.home_score stringValue];
    cell.fieldNameTextField.text = game.fieldName;

    return cell;
}
@end
