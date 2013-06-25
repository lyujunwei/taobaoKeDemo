//  AppDelegate.m
//  TB
//
//  Created by kimilee on 13-6-5.
//  Copyright (c) 2013年 kimilee. All rights reserved.
#import "AppDelegate.h"
#import "MainViewController.h"
#import "TBApiManage.h"
#import "AppUtility.h"
#import "HomeAPIParms.h"
#import "TBitem.h"


@implementation AppDelegate

- (void)umengTrack {
    
    [MobClick setAppVersion:XcodeAppVersion];
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] statusBarFrame];

    [self umengTrack];
    
    [MobClick setDelegate:self];
    
    [MobClick appLaunched];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [TBApiManage initTopIOSClient];
    
    _mainCtrl = [[MainViewController alloc]init];
    
    self.window.rootViewController = _mainCtrl;

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
       // [[AppUtility instance]saveDataSouseCacheByName:HOME_DATA_NAME data:[[AppUtility instance] getDataSouseByName:HOME_DATA_NAME]];
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
@end