//
//  Game.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/22.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Inning;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSString * ballType;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * endTm;
@property (nonatomic, retain) NSString * fieldName;
@property (nonatomic, retain) NSDate * gfTm;
@property (nonatomic, retain) NSString * guestName;
@property (nonatomic, retain) NSString * guestScore;
@property (nonatomic, retain) NSString * homeName;
@property (nonatomic, retain) NSString * homeScore;
@property (nonatomic, retain) NSString * inningSet;
@property (nonatomic, retain) NSString * timeSet;
@property (nonatomic, retain) NSSet *inningDetail;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addInningDetailObject:(Inning *)value;
- (void)removeInningDetailObject:(Inning *)value;
- (void)addInningDetail:(NSSet *)values;
- (void)removeInningDetail:(NSSet *)values;

@end
