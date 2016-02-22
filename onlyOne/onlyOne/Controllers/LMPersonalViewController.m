//
//  LMPersonalViewController.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPersonalViewController.h"

@interface LMPersonalViewController ()

@end

@implementation LMPersonalViewController

//初始化时设置tabBarItem
- (instancetype)init {
    if (self = [super init]) {
        [self setUpTabBarItemWithNormalImage:[UIImage imageNamed:@"tabbar_item_person"] selectedImage:[UIImage imageNamed:@"tabbar_item_person_selected"] title:@"个人"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigationBar:NO];
    [self hideBackButtonTitle];
}

@end
