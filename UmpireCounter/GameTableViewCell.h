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
@property (strong, nonatomic) IBOutlet UILabel *guestTeamNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *guestScoreTextField;
@property (strong, nonatomic) IBOutlet UILabel *homeScoreTextField;
@property (strong, nonatomic) IBOutlet UILabel *fieldNameTextField;
@end
