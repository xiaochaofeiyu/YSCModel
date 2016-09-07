//
//  YSCAppModelTools.h
//  YSCModel
//
//  Created by yushichao on 16/6/24.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCAppModelTools : NSObject

+ (NSArray*)getRandomInt:(NSInteger)number;
+ (NSArray *)getRandomHour:(NSInteger)number;
+ (NSString *)changeIntervalToTime:(NSString*)interval;
+ (CGFloat)oneLineStringHeight;
@end
