//
//  AppDelegate.m
//  onlyOne
//
//  Created by tarena on 16/2/15.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "AppDelegate.h"
#import "LMHomeViewController.h"
#import "LMArticleViewController.h"
#import "LMQuestionViewController.h"
#import "LMThingViewController.h"
#import "LMPersonalViewController.h"
#import "DSNavigationBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //首页
    LMHomeViewController *homeVC = [[LMHomeViewController alloc]init];
    UINavigationController *homeNavi = [self dSNavigationBar];
//    homeNavi.title = @"首页";
    homeNavi.viewControllers = @[homeVC];
    //文章
    LMArticleViewController *articleVC = [[LMArticleViewController alloc]init];
    UINavigationController *articleNavi = [self dSNavigationBar];
    articleNavi.title = @"文章";
    articleNavi.viewControllers = @[articleVC];
    //问题
    LMQuestionViewController *questionVC = [[LMQuestionViewController alloc]init];
    UINavigationController *questionNavi = [self dSNavigationBar];
    questionNavi.title = @"问题";
    questionNavi.viewControllers = @[questionVC];
    //东西
    LMThingViewController *thingVC = [[LMThingViewController alloc]init];
    UINavigationController *thingNavi = [self dSNavigationBar];
    thingNavi.title = @"东西";
    thingNavi.viewControllers = @[thingVC];
    //个人
    LMPersonalViewController *personalVC = [[LMPersonalViewController alloc]init];
    UINavigationController *personalNavi = [self dSNavigationBar];
    personalNavi.title = @"个人";
    personalNavi.viewControllers = @[personalVC];
    //设置navigationController
    UITabBarController *rootTabBarController = [[UITabBarController alloc]init];
    rootTabBarController.viewControllers = @[homeNavi,articleNavi,questionNavi,thingNavi,personalNavi];
    rootTabBarController.tabBar.tintColor = [UIColor colorWithRed:55 / 255.0 green:196 / 255.0 blue:242 / 255.0 alpha:1];
    rootTabBarController.tabBar.barTintColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    rootTabBarController.tabBar.backgroundColor = [UIColor clearColor];
    //设置根视图控制器
    self.window.rootViewController = rootTabBarController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (UINavigationController *)dSNavigationBar {
    UINavigationController *navi = [[UINavigationController alloc]initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    navi.navigationBar.tintColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:229 / 255.0];
    return navi;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
