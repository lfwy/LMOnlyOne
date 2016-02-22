//
//  LMHomeViewController.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHomeViewController.h"
#import "LMHomeTool.h"
#import "LMHomeView.h"
#import "LMRightPullToRefreshView.h"
@interface LMHomeViewController ()<LMRightPullToRefreshViewDelegate,LMRightPullToRefreshViewDataSource>

@property (nonatomic,strong) LMRightPullToRefreshView *rightPullToRefreshView;

@end

@implementation LMHomeViewController
{
    // 当前一共有多少篇文章，默认为3篇
    NSInteger numberOfItems;
    // 保存当前查看过的数据
    NSMutableDictionary *readItems;
    // 最后展示的 item 的下标
    NSInteger lastConfigureViewForItemIndex;
    // 当前是否正在右拉刷新标记
    BOOL isRefreshing;
}


//初始化时设置tabBarItem
- (instancetype)init {
    if (self = [super init]) {
        [self setUpTabBarItemWithNormalImage:[UIImage imageNamed:@"tabbar_item_home"] selectedImage:[UIImage imageNamed:@"tabbar_item_home_selected"] title:@"首页"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavigationBar:YES];
    //加载默认设置
    [self configSetting];
    
}

- (void)configSetting {
    numberOfItems = 2;
    readItems = [[NSMutableDictionary alloc] init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置右拉刷新视图
    self.rightPullToRefreshView = [[LMRightPullToRefreshView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
    self.rightPullToRefreshView.delegate = self;
    self.rightPullToRefreshView.dataSource = self;
    [self.view addSubview:self.rightPullToRefreshView];
    
    [self requestHomeContentAtIndex:0];
}

#pragma mark - dataSource 
- (NSInteger)numberOfItemsInRightPullToRefreshView:(LMRightPullToRefreshView *)rightPullToRefreshView {
    return numberOfItems;
}

- (UIView *)rightPullToRefreshView:(LMRightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    LMHomeView *homeView = nil;
    
//    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
        homeView = [[LMHomeView alloc] initWithFrame:view.bounds];
        [view addSubview:homeView];
//    } else {
//        
//        homeView = (LMHomeView *)view.subviews[0];
//    }
    if (index == numberOfItems - 1 || index == readItems.allKeys.count) {// 当前这个 item 是没有展示过的
        [homeView refreshSubviewsForNewItem];
    } else {// 当前这个 item 是展示过了但是没有显示过数据的
        lastConfigureViewForItemIndex = MAX(index, lastConfigureViewForItemIndex);
        NSLog(@"%ld",index);
        [homeView setUpHomeViewWithHomeModal:readItems[[@(index) stringValue]] animated:YES];
    }
    return view;
}

#pragma mark - RightPullToRefreshViewDelegate

- (void)rightPullToRefreshViewRefreshing:(LMRightPullToRefreshView *)rightPullToRefreshView {
    [self refreshing];
}

- (void)rightPullToRefreshView:(LMRightPullToRefreshView *)rightPullToRefreshView didDisplayItemAtIndex:(NSInteger)index {
    if (index == numberOfItems - 1) {// 如果当前显示的是最后一个，则添加一个 item
        numberOfItems++;
        [self.rightPullToRefreshView insertItemAtIndex:(numberOfItems - 1) animated:YES];
    }
    if (index < readItems.allKeys.count && readItems[[@(index) stringValue]]) {
        LMHomeView *homeView = (LMHomeView *)[rightPullToRefreshView itemViewAtIndex:index].subviews[0];
        [homeView setUpHomeViewWithHomeModal:readItems[[@(index) stringValue]] animated:(lastConfigureViewForItemIndex == 0 || lastConfigureViewForItemIndex < index)];
    } else {
        [self requestHomeContentAtIndex:index];
    }
}

- (void)rightPullToRefreshViewCurrentItemIndexDidChange:(LMRightPullToRefreshView *)rightPullToRefreshView {
    if (isGreatThanIOS9) {
        UIView *currentItemView = [rightPullToRefreshView currentItemView];
        for (id subView in rightPullToRefreshView.contentView.subviews) {
            if (![subView isKindOfClass:[UILabel class]]) {
                UIView *itemView = (UIView *)subView;
                LMHomeView *homeView = (LMHomeView *)itemView.subviews[0].subviews[0];
                UIScrollView *scrollView = (UIScrollView *)[homeView viewWithTag:ScrollViewTag];
                if (itemView == currentItemView.superview) {
                    scrollView.scrollsToTop = YES;
                } else {
                    scrollView.scrollsToTop = NO;
                }
            }
        }
    }
}

#pragma mark - Network Requests

// 右拉刷新
- (void)refreshing {
    if (readItems.allKeys.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
        [self showHUDWithText:@""];
        isRefreshing = YES;
        [self requestHomeContentAtIndex:0];
    }
}

- (void)requestHomeContentAtIndex:(NSInteger)index {
    [LMHomeTool requestHomeDataFromSeverByIndex:index success:^(LMHomeModal *homeModal) {
        
        if (isRefreshing) {
            [self endRefreshing];
            if ([homeModal.strHpId isEqualToString:((LMHomeModal *)readItems[@"0"]).strHpId]) {
                [self showHUDWithText:IsLatestData delay:HUD_DELAY];
            }else {
                [readItems removeAllObjects];
                [self hideHud];
            }
            [self endRequestHomeContent:homeModal atIndex:index];
        } else {
            [self hideHud];
            [self endRequestHomeContent:homeModal atIndex:index];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Private

- (void)endRefreshing {
    isRefreshing = NO;
    [self.rightPullToRefreshView endRefreshing];
}

- (void)endRequestHomeContent:(LMHomeModal *)homeModal atIndex:(NSInteger)index {
    [readItems setObject:homeModal forKey:[@(index) stringValue]];
    [self.rightPullToRefreshView reloadItemAtIndex:index animated:NO];
}

//销毁时 清空设置
- (void)dealloc {
    self.rightPullToRefreshView.delegate = nil;
    self.rightPullToRefreshView.dataSource = nil;
    self.rightPullToRefreshView = nil;
}

@end
