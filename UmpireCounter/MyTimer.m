//
//  MyTimer.m
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/4/1.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import "MyTimer.h"
#define TimeUnin 0.01   // 1 sec
@interface MyTimer()
@property (nonatomic) NSTimer  *timer;
@property UITabBarController *tabBarController;
@property (nonatomic) int  min;
@property (nonatomic) int  sec;
@property (nonatomic) int  minSec;

@property (nonatomic) int  nowTime;
@property (nonatomic) int  lastTime;
@property bool isRunning;
@end

@implementation MyTimer

- (void) initTimerStartCountFrom: (NSString *)startCountMinute WithTabBarController: (UITabBarController *)tabBarController
{
    
    _tabBarController = tabBarController;
    _nowTime = [startCountMinute intValue] * 6000;
//    _nowTime = 100;

    _timer = [NSTimer scheduledTimerWithTimeInterval:TimeUnin
                                              target:self
                                            selector:@selector(Timer_Count)
                                            userInfo:nil
                                             repeats:YES];


}

- (void)Timer_Count {

    if (_nowTime > 0){
        _nowTime-- ;
        [self showNowTime];
    }else{
        [_timer invalidate];
        _timer = nil;//作廢計時器
        _tabBarController.navigationItem.title = @"已超過比賽時間";
    }
}


- (void) showNowTime
{
    _min = _nowTime  / 6000;
    _sec = (_nowTime % 6000) /100 ;
    
    _tabBarController.navigationItem.title =   [NSString stringWithFormat:@"剩餘時間 %02d分%02d秒", _min, _sec];
    
}

@end
