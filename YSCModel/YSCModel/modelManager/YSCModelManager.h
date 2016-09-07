//
//  YSCModelManager.h
//  YSCModel
//
//  Created by yushichao on 16/6/18.
//  Copyright © 2016年 yushichao. All rights reserved.
//

//RebuilderKey
#define kRebuilderComment         @"Comment"
#define kRebuilderShare           @"Share"

//分享
#define kShareTitle               @"kShareTitle"
#define kShareImage               @"kShareImage"
#define kShareSummary             @"kShareSummary"
#define kShareUrl                 @"kShareUrl"

//评论
#define kSpecialReportsCommentHasComment        @"kSpecialReportsCommentHasComment"
#define kSpecialReportsCommentContent           @"kSpecialReportsCommentContent"
#define kSpecialReportsCommentUserName          @"kSpecialReportsCommentUserName"
#define kSpecialReportsCommentCreateTime        @"kSpecialReportsCommentCreateTime"
#define kSpecialReportsCommentTotalCount        @"kSpecialReportsCommentTotalCount"

#import <Foundation/Foundation.h>
#import "YSCAppModelTools.h"

//解析相应类型的数据类必须实现此协议
@protocol YSCBaseDataRebuilderProtocol <NSObject>

@required

@optional

- (id)rebuildData:(NSDictionary *)originData;
- (NSString*)provideKeyPath;

@end


@protocol YSCModelManagerDelegate <NSObject>

- (void)saveDataCompletedCallBack;

@end

@class YSCModelManager;

//YSCModelManager的子类必须实现此协议
@protocol YSCModelManagerBaseProtocol <NSObject>

@optional

@property (nonatomic, strong) NSMutableDictionary *dataDic;//存储处理后的数据
@property (nonatomic, weak) id<YSCModelManagerDelegate> delegate;

+ (YSCModelManager<YSCModelManagerBaseProtocol> *)shareManager;
- (void)saveDataToManager:(NSDictionary *)dic;//存入数据
- (id)getDataFromManagerWithKey:(NSString *)key;
- (void)cleanAllDatas;

@end

@interface YSCModelManager : NSObject

- (id<YSCBaseDataRebuilderProtocol>)getDataRebuilderInstanseWithKey:(NSString *)rebuilderKey;
- (NSDictionary *)rebuildData:(NSDictionary *)data withRebuilder:(id<YSCBaseDataRebuilderProtocol>)rebuilder;

@end
