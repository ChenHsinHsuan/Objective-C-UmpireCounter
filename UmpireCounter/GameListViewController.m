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
#import "GameDetailViewController.h"
#import "AppDelegate.h"
#import "ScoreBoxViewController.h"
@interface GameListViewController ()
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *gameListTableView;
@property Game *selectGame;
@end

@implementation GameListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated
{
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.gameListTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





#pragma mark - Fetched results controller

/*
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {
    // 如果查詢結果已經存在就直接返回_fetchedResultsController
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    // 1.創建NSFetchRequest對象（相當於SQL語句）
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 2.創建查詢實體（相當於設置查詢哪個表）
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // 設置獲取數據的批數
//    [fetchRequest setFetchBatchSize:20];
    
    // 3.創建排序描述符（ascending：是否升序）
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gfTm" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // 根據fetchRequest和managedObjectContext來創建aFetchedResultsController對象，並設置緩存名字為"Master"
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];

    return _fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.gameListTableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.gameListTableView endUpdates];
}


#pragma -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
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
    Game *game = [_fetchedResultsController objectAtIndexPath:indexPath];

    cell.guestTeamNameLabel.text =  game.guestName;
    cell.homeTeamNameLabel.text = game.homeName;
    cell.fieldNameLabel.text = game.fieldName;
    cell.guestScoreLabel.text = game.guestScore;
    cell.homeScoreLabel.text = game.homeScore;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameTableViewCell *cell = (GameTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell != nil){
        self.selectGame =  [_fetchedResultsController objectAtIndexPath:indexPath];
        
        if (self.selectGame.completed) {
            [self performSegueWithIdentifier:@"GameScoreBox" sender:cell];
        }else{
            [self performSegueWithIdentifier:@"gameDetail" sender:cell];
        }
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //判斷編輯表格的類型為「刪除」
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Game *gameToDelete = [_fetchedResultsController objectAtIndexPath:indexPath];
        NSManagedObjectContext * context = [_fetchedResultsController managedObjectContext];
        [context deleteObject:gameToDelete];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

    }

    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.gameListTableView reloadData];
}

#pragma mark - segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"gameDetail"]){
        GameDetailViewController *destVC = [segue destinationViewController];
        destVC.game = self.selectGame;
    }
    
    if([segue.identifier isEqualToString:@"AddGame"]){
        Game *newGame = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:_managedObjectContext];
        AddGameViewController *addGameVC = [segue destinationViewController];
        addGameVC.game = newGame;
    }
    
    if([segue.identifier isEqualToString:@"GameScoreBox"]){
        ScoreBoxViewController *destVC = [segue destinationViewController];
        destVC.game = self.selectGame;
    }
    
}

- (IBAction)saveGameToList:(UIStoryboardSegue *)segue
{
    [self saveGame];
}

-(IBAction)CancelAddGameToList:(UIStoryboardSegue *)segue
{
    AddGameViewController *addGameVC = [segue sourceViewController];
    [_managedObjectContext deleteObject:addGameVC.game];
}


-(void)saveGame
{
    NSError *error;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
