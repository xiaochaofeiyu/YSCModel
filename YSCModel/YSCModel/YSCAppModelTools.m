//
//  YSCAppModelTools.m
//  YSCModel
//
//  Created by yushichao on 16/6/24.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import "YSCAppModelTools.h"

@implementation YSCAppModelTools

+ (NSArray *)getRandomInt:(NSInteger)number
{
    NSMutableArray *randoms = [NSMutableArray array];
    for (int i=0; i<number; i++) {
        int randomInt = arc4random()%59*60;
        NSNumber *random = [NSNumber numberWithInt:randomInt];
        [randoms addObject:random];
    }
    
    NSArray *sorts = nil;
    if (randoms.count>0) {
        sorts = [randoms sortedArrayUsingSelector:@selector(compare:)];
    }
    
    return sorts;
}

+ (NSArray *)getRandomHour:(NSInteger)number
{
    NSMutableArray *randoms = [NSMutableArray array];
    for (int i=0; i<number; i++) {
        int randomHour = arc4random()%23*3600;
        //int randomMin = arc4random()%59*60;
        NSNumber *random = [NSNumber numberWithInt:randomHour/*+randomMin*/];
        [randoms addObject:random];
    }
    
    NSArray *sorts = nil;
    if (randoms.count>0) {
        sorts = [randoms sortedArrayUsingSelector:@selector(compare:)];
    }
    
    return sorts;
}

+ (NSString *)changeIntervalToTime:(NSString*)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSString *timeStr = [interval stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (CGFloat)oneLineStringHeight
{
    NSString *oneLineString = @"哈哈";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:oneLineString];
    NSMutableParagraphStyle *paragraphStyle = [[ NSMutableParagraphStyle alloc ] init ];
    paragraphStyle.alignment = NSTextAlignmentLeft ;
    paragraphStyle.maximumLineHeight = 60 ;  //最大的行高
    [paragraphStyle setFirstLineHeadIndent:47.5]; //首行缩进
    paragraphStyle.lineSpacing = 5;
    [attributedString addAttribute: NSParagraphStyleAttributeName value :paragraphStyle range : NSMakeRange ( 0 , [oneLineString length])];
    
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    CGSize textSize = [oneLineString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle} context:nil].size;
    
    return textSize.height;
}

@end
