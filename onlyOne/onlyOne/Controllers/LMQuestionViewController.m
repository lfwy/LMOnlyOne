//
//  LMQuestionViewController.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMQuestionViewController.h"
#import "LMQuestionTool.h"

@interface LMQuestionViewController ()

@end

@implementation LMQuestionViewController

//初始化时设置tabBarItem
- (instancetype)init {
    if (self = [super init]) {
        [self setUpTabBarItemWithNormalImage:[UIImage imageNamed:@"tabbar_item_question"] selectedImage:[UIImage imageNamed:@"tabbar_item_question_selected"] title:@"问题"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigationBar:YES];
    
    [LMQuestionTool requestQuestionDataFromSeverByDate:@"2016-02-15" lastUpdateDate:@"2016-02-15" success:^(LMQuestionModal *questionModal) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
