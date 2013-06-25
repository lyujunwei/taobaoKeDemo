//
//  MainViewController.m
//  TB
//
//  Created by zucknet on 13/6/6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
//#import "AboutViewController.h"
#import "BaseNavigationController.h"
#import "itemDetailViewController.h"
#import "ABoutViewController.h"

#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()

@end

@implementation MainViewController

- (void)_initViewController {
    HomeViewController *home = [[HomeViewController alloc] init];
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    ABoutViewController *more = [[    ABoutViewController alloc] init];
     
    home.title = @"首页";
    discover.title = @"搜索";
    profile.title =@"收藏";
    more.title = @"关于";
    
    [home.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_home2"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_home"]];
    [discover.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_hot2"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_hot"]];
    [profile.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_fav2"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_fav"]];
    [more.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_about2"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_about"]];
    
    NSArray *views = @[home,discover,profile,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
    }
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initViewController];
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar"];

    [[UITabBar appearance] setBackgroundImage:tabBarBackground];

    [self.tabBar setSelectedImageTintColor:[UIColor lightGrayColor]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
