//
//  Game.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/6.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Inning;

@interface Game : NSObject

@property (nonatomic, retain) NSString * ball_type;
@property (nonatomic, retain) NSString * guest_team_name;
@property (nonatomic, retain) NSString * home_team_name;
@property (nonatomic, retain) NSNumber * inning;
@property (nonatomic, retain) NSDate * game_time;
@property (nonatomic, retain) NSString * fieldName;


@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSMutableArray *inningArr;
@property (nonatomic, retain) NSNumber * guest_score;
@property (nonatomic, retain) NSNumber * home_score;
@end

