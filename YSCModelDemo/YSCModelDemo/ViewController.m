//
//  ViewController.m
//  YSCModelDemo
//
//  Created by yushichao on 16/9/6.
//  Copyright © 2016年 YSC. All rights reserved.
//

#import "ViewController.h"
#import "YSCModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //网络请求
    [[YSCNetworkingManager sharedManager] getWithUrl:@"xxxxx" params:nil success:^(id response) {
        if (response) {
            [[YSCTestDemoModelManager shareManager] saveDataToManager:response];//存储数据
        }
        
    } fail:^(NSError *error) {
        
    } showHUD:NO];
    
    [[YSCTestDemoModelManager shareManager] saveDataToManager:@{}];//存储数据
    
    //获取评论数据
    NSDictionary *commentDic = [[YSCTestDemoModelManager shareManager] getDataFromManagerWithKey:kCommentSectionData];
    NSLog(@"%@", commentDic);
    
    //获取分享数据
    NSDictionary *shareDic = [[YSCTestDemoModelManager shareManager] getDataFromManagerWithKey:kShareDataDic];
    NSLog(@"%@", shareDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
