//
//  GameListViewController.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/5.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GameListViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
- (IBAction)addGameToList:(UIStoryboardSegue *)segue;
@end
