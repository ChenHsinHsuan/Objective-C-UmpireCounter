//
//  ScoreBoxCell.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/9.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ScoreBoxCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *inningTextField;
@property (strong, nonatomic) IBOutlet UILabel *guestScoreTextField;
@property (strong, nonatomic) IBOutlet UILabel *homeScoreTextField;
@end
