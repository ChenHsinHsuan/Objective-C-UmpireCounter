//
//  ScoreBoxViewController.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/9.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "ScoreBoxViewController.h"
#import "ScoreBoxCell.h"
#import "Inning.h"
@interface ScoreBoxViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *guestNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeNameLabel;

@end

@implementation ScoreBoxViewController

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
    if(self.game.inningArr == nil){
        self.game.inningArr = [[NSMutableArray alloc]init];
    }

    self.guestNameLabel.text = self.game.guest_team_name;
    self.homeNameLabel.text = self.game.home_team_name;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.game.inningArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //製作可重復利用的表格欄位Cell
    static NSString *CellIdentifier = @"ScoreBoxCell";
    
    ScoreBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell = [[ScoreBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //設定欄位的內容與類型
    if(indexPath.row == self.game.inningArr.count){
        cell.inningTextField.text = @"總分";
        int totalGuestScore = 0;
        int totalHomeScore = 0;
        Inning *inning;
        for(int i = 0; i < self.game.inningArr.count; i++){
            inning = self.game.inningArr[i];
            totalGuestScore += inning.guestScore;
            totalHomeScore += inning.homeScore;
        }
        cell.guestScoreTextField.text = [[NSString alloc] initWithFormat:@"%d", totalGuestScore];
        cell.homeScoreTextField.text = [[NSString alloc] initWithFormat:@"%d", totalHomeScore];
    }else{
        Inning *inning = [self.game.inningArr objectAtIndex:indexPath.row];
        cell.inningTextField.text = [[NSString alloc] initWithFormat:@"%d",inning.inning];
        cell.guestScoreTextField.text = [[NSString alloc] initWithFormat:@"%d",inning.guestScore];
        cell.homeScoreTextField.text = [[NSString alloc] initWithFormat:@"%d",inning.homeScore];
    }
    
    return cell;
}

@end
