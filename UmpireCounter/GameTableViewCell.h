//
//  GameTableViewCell.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/6.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
@interface GameTableViewCell : UITableViewCell
@property Game *game;
@property (strong, nonatomic) IBOutlet UILabel *guestTeamNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *guestScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *fieldNameLabel;
@end
