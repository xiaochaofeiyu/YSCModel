//
//  YSCModelManager.m
//  YSCModel
//
//  Created by yushichao on 16/6/18.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import "YSCModelManager.h"

@interface YSCModelManager ()

@end

@implementation YSCModelManager

//+ (YSCModelManager *)shareManager
//{
//    static YSCModelManager *handler = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        handler = [[YSCModelManager alloc] init];
//    });
//    return handler;
//}

- (id<YSCBaseDataRebuilderProtocol>)getDataRebuilderInstanseWithKey:(NSString *)rebuilderKey
{
    id<YSCBaseDataRebuilderProtocol> rebuilderInstanse = nil;
    NSString *className = @"YSCDataRebuilder";
    className = [className stringByAppendingString:rebuilderKey];

    Class rebuilderClass = NSClassFromString(className);
    rebuilderInstanse = [[rebuilderClass alloc] init];
    
    return rebuilderInstanse;
}

- (NSDictionary *)rebuildData:(NSDictionary *)data withRebuilder:(id<YSCBaseDataRebuilderProtocol>)rebuilder
{
    if (!data || ![data isKindOfClass:[NSDictionary class]] || !rebuilder) {
        return nil;
    } else {
        return [rebuilder rebuildData:data];
    }
}

@end
