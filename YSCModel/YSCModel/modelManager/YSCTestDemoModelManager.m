//
//  YSCTestDemoModelManager.m
//  YSCModel
//
//  Created by yushichao on 16/6/22.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import "YSCTestDemoModelManager.h"

@interface YSCTestDemoModelManager ()

@property (nonatomic, strong) NSMutableDictionary *commentSectionData;   //table中最后一个section即评论的数据
@property (nonatomic, strong) NSMutableDictionary *shareDataDic;        //分享数据

@end

@implementation YSCTestDemoModelManager

+ (YSCTestDemoModelManager *)shareManager
{
    static YSCTestDemoModelManager *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[YSCTestDemoModelManager alloc] init];
        [handler initDatas];
    });
    return handler;
}

- (void)initDatas
{
    self.dataDic = [NSMutableDictionary dictionary];
    _commentSectionData = [NSMutableDictionary dictionary];
    _shareDataDic = [NSMutableDictionary dictionary];
}

- (void)cleanAllDatas
{
    [_commentSectionData removeAllObjects];
    [_shareDataDic removeAllObjects];
}

/**
 *  根据Key获取解析后相应的数据
 *
 *  @param key 可设置为kCommentSectionData & kShareDataDic，分别代表获取解析后的评论数据和分享数据
 *
 *  @return 解析后数据
 */
- (id)getDataFromManagerWithKey:(NSString *)key
{
    return [self.dataDic objectForKey:key];
}

- (void)saveDataToManager:(NSDictionary *)dic
{
    NSDictionary *topic = [dic objectForKey:@"topic/read"];
    if ([topic isEqual:[NSNull null]]||!topic||topic.count==0) {
        if ([self.delegate respondsToSelector:@selector(dealDataWithErrorString:)]) {
            [self.delegate dealDataWithErrorString:@"数据错误"];
        }
        return;
    }
    int status = [[topic objectForKey:@"status"] intValue];
    if (status != 0) {
        if ([self.delegate respondsToSelector:@selector(dealDataWithErrorString:)]) {
            [self.delegate dealDataWithErrorString:@"数据错误"];
        }
        return;
    }
    
    NSDictionary *data = [topic objectForKey:@"data"];
    if ([data isEqual:[NSNull null]]||!data||data.count == 0) {
        if ([self.delegate respondsToSelector:@selector(dealDataWithErrorString:)]) {
            [self.delegate dealDataWithErrorString:@"数据错误"];
        }
        return;
    }
    
    //分享数据
    id<YSCBaseDataRebuilderProtocol> shareRebuilder = [self getDataRebuilderInstanseWithKey:kRebuilderShare];
    if (shareRebuilder) {
        NSMutableDictionary *shareDic = (NSMutableDictionary *)[self rebuildData:data withRebuilder:shareRebuilder];
        if (shareDic && shareDic.count > 0) {
            _shareDataDic = shareDic;
        }
    }
    
    //评论数据
    id<YSCBaseDataRebuilderProtocol> commentRebuilder = [self getDataRebuilderInstanseWithKey:kRebuilderComment];
    if (commentRebuilder) {
        NSMutableDictionary *commentDic = (NSMutableDictionary *)[self rebuildData:dic withRebuilder:commentRebuilder];
        if (commentDic && commentDic.count > 0) {
            _commentSectionData = commentDic;
        }
    }

    [self.dataDic setObject:_commentSectionData forKey:kCommentSectionData];
    [self.dataDic setObject:_shareDataDic forKey:kShareDataDic];
    
    if ([self.delegate respondsToSelector:@selector(saveDataCompletedCallBack)]) {
        [self.delegate saveDataCompletedCallBack];
    }
}

@end
