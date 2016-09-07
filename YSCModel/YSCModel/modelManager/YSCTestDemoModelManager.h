//
//  YSCTestDemoModelManager.h
//  YSCModel
//
//  Created by yushichao on 16/6/22.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#define kCommentSectionData          @"kCommentSectionData"
#define kShareDataDic                @"kShareDataDic"

#import "YSCModelManager.h"

@protocol YSCTestDemoModelManagerDelegate <YSCModelManagerDelegate>

- (void)dealDataWithErrorString:(NSString *)errorString;

@end

@interface YSCTestDemoModelManager : YSCModelManager<YSCModelManagerBaseProtocol>

@property (nonatomic, weak) id<YSCTestDemoModelManagerDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dataDic;//存储处理后的数据

@end
