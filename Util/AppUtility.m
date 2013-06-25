//
//  AppUtility.m
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "AppUtility.h"
#import "TBCache.h"
#import "SVProgressHUD.h"
#import "itemDetailViewController.h"
#import "WebViewViewController.h"
@implementation AppUtility
@synthesize homeData = _homeData;
@synthesize discoverData = _discoverData;
@synthesize homeImageHight = _homeImageHight;
@synthesize discoverImageHight = _discoverImageHight;
@synthesize detailView = _detailView;
@synthesize webView;
+(AppUtility *)instance
{
    static AppUtility *appUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (appUtility == nil) {
            appUtility = [[super allocWithZone:nil] init];
            if (!appUtility.homeData)
            {
                appUtility.homeData  = [[NSMutableArray alloc]init];
            }
            if (!appUtility.discoverData)
            {
                appUtility.discoverData  = [[NSMutableArray alloc]init];
            }
            if (!appUtility.discoverImageHight)
            {
                appUtility.discoverImageHight  = [[NSMutableArray alloc]init];
            }
            if(!appUtility.homeImageHight)
            {
                appUtility.homeImageHight = [[NSMutableArray alloc]init];
            }
            if (!appUtility.detailView) {
                appUtility.detailView = [[itemDetailViewController alloc]init];
            }
//            if (!appUtility.webView) {
//                appUtility.webView = [[WebViewViewController alloc]init];
//            }
        }
    });
    return appUtility;
}
-(void)removeHomeAllObject
{
    [self.homeData removeAllObjects];
}
-(void)removeDiscoverAllObject
{
    [self.discoverData removeAllObjects];
}
-(void)saveDataSouseCacheByName:(NSString *)name
{
    [TBCache setObject:[self getDataSouseByName:name] forKey:name];
}
-(id)getDataSouseByName:(NSString *)name
{
    return [TBCache getObjectForKey:name];
}

+(BOOL)writePlist:(NSString*)plistName
          wObjext:(id)wObject
{
    return YES;
}

+(void)postNotificationWithTpye:(NSString*)type
                           info:(NSDictionary*)info
{
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:type object:nil userInfo:info]];
}
+(void)showMassage:(NSString*)tpye
{
    [SVProgressHUD showProgress:2 status:tpye maskType:SVProgressHUDMaskTypeBlack];
}

+(void)unshowMassage
{
    [SVProgressHUD dismiss];
}
+(NSMutableArray * )getRandomNumber:(int)i
{

    NSMutableArray *arr = [[NSMutableArray alloc]init];
    int a = arc4random()%i/2;
    while (arr.count<9)
    {
        

        if (arr.count==0) {
            [arr addObject:[NSNumber numberWithInt:a]];
        }
        else
        {
            int b = arc4random()%(i/2)/8;
            if (b==0) {
                b=1;
            }
            a = a+b;
            [arr addObject:[NSNumber numberWithInt:a]];
        }
    }
return arr;
}
@end