//
//  YSCDataRebuilderShare.m
//  YSCModel
//
//  Created by yushichao on 16/6/26.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import "YSCDataRebuilderShare.h"

@implementation YSCDataRebuilderShare

- (id)rebuildData:(NSDictionary *)originData
{
    NSMutableDictionary *returnShareDic = [NSMutableDictionary dictionary];
    
    NSDictionary *sharedic = [originData objectForKey:@"yummy_share"];
    if (![sharedic isKindOfClass:[NSDictionary class]] || sharedic.count <= 0) {
        return nil;
    }
    id value = nil;
    
    value = [sharedic valueForKeyPath:@"image"];
    if (value) {
        value = [NSString stringWithFormat:@"%@",value];
        [returnShareDic setObject:value forKey:kShareImage];
    }
    value = [sharedic valueForKeyPath:@"summary"];
    if (value) {
        value = [NSString stringWithFormat:@"%@",value];
        [returnShareDic setObject:value forKey:kShareSummary];
    }
    value = [sharedic valueForKeyPath:@"title"];
    if (value) {
        value = [NSString stringWithFormat:@"%@",value];
        [returnShareDic setObject:value forKey:kShareTitle];
    }
    value = [sharedic valueForKeyPath:@"url"];
    if (value) {
        value = [NSString stringWithFormat:@"%@",value];
        [returnShareDic setObject:value forKey:kShareUrl];
    }
    
    return returnShareDic;
}

@end
