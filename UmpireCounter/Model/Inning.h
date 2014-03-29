//
//  Inning.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/22.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Inning : NSManagedObject

@property (nonatomic, retain) NSString * guestScore;
@property (nonatomic, retain) NSString * homeScore;
@property (nonatomic, retain) NSString * sn;
@property (nonatomic, retain) Game *game;

@end
