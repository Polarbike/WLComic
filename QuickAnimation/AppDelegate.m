//
//  AppDelegate.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "AppDelegate.h"
#import "Moduels/HomeModule/HomeViewController.h"
#import "Moduels/DiscoverModule/DiscoverViewController.h"
#import "Moduels/WorldModule/WorldViewController.h"
#import "Moduels/MineModule/MineViewController.h"
#import "SearchViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //
    //设置tabbarViewController
    //
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.hidesBottomBarWhenPushed = YES;
    //去掉字体渲染
    NSMutableDictionary *atts=[NSMutableDictionary dictionary];
    // 更改文字大小
    atts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    // 更改文字颜色
    atts[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    NSMutableDictionary *selectedAtts=[NSMutableDictionary dictionary];
    selectedAtts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectedAtts[NSForegroundColorAttributeName] = kRGB(251, 227, 76, 1);
    //[vc01.tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    //精选模块
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *home_NVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    home_NVC.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_home_normal_30x30_"];
    UIImage *home_sel = [UIImage imageNamed:@"ic_tabbar_home_pressed_30x30_"];
    home_sel = [home_sel imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    home_NVC.tabBarItem.selectedImage = home_sel;
    [home_NVC.tabBarItem setTitleTextAttributes:selectedAtts forState:(UIControlStateSelected)];
    home_NVC.tabBarItem.title = @"首页";
    //讨论模块
//    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
//    UINavigationController *discover_NVC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
//    discover_NVC.tabBarItem.title = @"搜索";
//    [discover_NVC.tabBarItem setTitleTextAttributes:selectedAtts forState:(UIControlStateSelected)];
//    UIImage *discu_sele = [UIImage imageNamed:@"ic_tabbar_discover_pressed_30x30_"];
//    discu_sele = [discu_sele imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//
//    discover_NVC.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_discover_normal_30x30_"];
//    discover_NVC.tabBarItem.selectedImage = discu_sele;
    //搜索页面
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    UINavigationController *search_NVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    search_NVC.title = @"搜索";
    [search_NVC.tabBarItem setTitleTextAttributes:selectedAtts forState:(UIControlStateSelected)];
    UIImage *discu_sele = [UIImage imageNamed:@"ic_tabbar_discover_pressed_30x30_"];
    discu_sele = [discu_sele imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    search_NVC.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_discover_normal_30x30_"];
    search_NVC.tabBarItem.selectedImage = discu_sele;
    //世界模块
    WorldViewController *worldVC = [[WorldViewController alloc] init];
    UINavigationController *world_nvc = [[UINavigationController alloc] initWithRootViewController:worldVC];
    world_nvc.tabBarItem.title = @"分类";
    [world_nvc.tabBarItem setTitleTextAttributes:selectedAtts forState:(UIControlStateSelected)];
    world_nvc.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_media_normal_30x30_"];
    UIImage *collect_sele = [UIImage imageNamed:@"ic_tabbar_media_pressed_30x30_"];
    collect_sele = [collect_sele imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    world_nvc.tabBarItem.selectedImage = collect_sele;
    //我的模块
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mine_NVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mine_NVC.tabBarItem.title = @"我的";
    [mine_NVC.tabBarItem setTitleTextAttributes:selectedAtts forState:(UIControlStateSelected)];
    mine_NVC.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_me_normal_30x30_"];
    UIImage *mine_cele = [UIImage imageNamed:@"ic_tabbar_me_pressed_30x30_"];
    mine_cele = [mine_cele imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    mine_NVC.tabBarItem.selectedImage = mine_cele;
    
    [tabBarVC setViewControllers:@[home_NVC,search_NVC,world_nvc,mine_NVC]];
    //
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    self.window.rootViewController = tabBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
