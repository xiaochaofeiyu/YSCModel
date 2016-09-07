//
//  YSCDataRebuilderComment.m
//  YSCModel
//
//  Created by yushichao on 16/6/26.
//  Copyright © 2016年 yushichao. All rights reserved.
//

#import "YSCDataRebuilderComment.h"

@implementation YSCDataRebuilderComment

- (id)rebuildData:(NSDictionary *)originData
{
    //评论数据
    NSDictionary *comment = [originData objectForKey:@"comment/getreply"];
    if ([comment isEqual:[NSNull null]]||!comment||comment.count==0) {
        return nil;
    }
    NSInteger status = [[comment objectForKey:@"status"] intValue];
    if (status != 0) {
        return nil;
    }
    
    NSDictionary *data = [comment objectForKey:@"data"];
    if ([data isEqual:[NSNull null]]||!data||data.count == 0) {
        return nil;
    }
    
    return [self dealCommentData:data];
}

- (NSMutableDictionary *)dealCommentData:(NSDictionary *)dic
{
    NSMutableDictionary *commentDic = [NSMutableDictionary dictionary];
    id value = nil;
    value = dic[@"total_count"];
    if (value) {
        value = [NSNumber numberWithInteger:[value integerValue]];
        [commentDic setObject:value forKey:kSpecialReportsCommentTotalCount];
    }
    
    NSArray *commentList = [dic objectForKey:@"list"];
    if ([commentList isKindOfClass:[NSArray class]] && commentList.count > 0) {
        NSDictionary *firstComment = commentList[0];
        
        value = firstComment[@"content"];
        if (value) {
            value = [NSString stringWithFormat:@"%@",value];
            [commentDic setObject:value forKey:kSpecialReportsCommentContent];
        }
        value = [firstComment valueForKeyPath:@"user_name"];
        if (value) {
            value = [NSString stringWithFormat:@"%@",value];
            [commentDic setObject:value forKey:kSpecialReportsCommentUserName];
        }
        value = [firstComment valueForKeyPath:@"create_time"];
        if (value) {
            value = [NSString stringWithFormat:@"%@",value];
            value = [YSCAppModelTools changeIntervalToTime:value];
            [commentDic setObject:value forKey:kSpecialReportsCommentCreateTime];
        }
        [commentDic setObject:@YES forKey:kSpecialReportsCommentHasComment];
    }
    
    return commentDic;
}

@end
