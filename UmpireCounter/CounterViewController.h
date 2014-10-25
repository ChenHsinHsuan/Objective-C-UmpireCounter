//
//  CounterViewController.h
//  UmpireCounter
//
//  Created by Chen Hsin-Hsuan on 2014/3/8.
//  Copyright (c) 2014年 com.aircon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import <iAd/iAd.h>
#import <AudioToolbox/AudioToolbox.h>
@interface CounterViewController : UIViewController<UIAlertViewDelegate, ADBannerViewDelegate>
@property Game *game;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@end
