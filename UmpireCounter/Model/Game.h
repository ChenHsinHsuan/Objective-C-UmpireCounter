//
//  Game.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/5.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
@property NSString *ballType;//球的種類
@property NSString *homeTeamName;//主場球隊名稱
@property NSString *guestTeamName;//客場球隊名稱
@property NSNumber *inning;//比賽局數
@property NSDate *gameTime;//比賽時間
@property BOOL *completed;//是否結束
@end
