//
//  AppUtility.h
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class itemDetailViewController;
@class WebViewViewController;
@interface AppUtility : NSObject
{
    NSMutableArray * _homeData;
    NSMutableArray * _discoverData;
    NSMutableArray * _discoverImageHight;
    NSMutableArray * _homeImageHight;
    itemDetailViewController * _detailView;

}
@property(nonatomic,strong)WebViewViewController* webView;
@property(nonatomic,strong)itemDetailViewController *detailView;
@property(nonatomic,strong)NSMutableArray * homeImageHight;
@property(nonatomic,strong)NSMutableArray * homeData;
@property(nonatomic,strong)NSMutableArray *discoverData;
@property(nonatomic,strong)NSMutableArray *discoverImageHight;
-(void)removeHomeAllObject;
-(void)removeDiscoverAllObject;

+(AppUtility *)instance;
+(void)showMassage:(NSString*)tpye;
+(void)unshowMassage;

+(NSMutableArray * )getRandomNumber:(int)i;

-(id)getDataSouseByName:(NSString *)name;

-(void)saveDataSouseCacheByName:(NSString *)name;

+(BOOL)writePlist:(NSString*)plistName
          wObjext:(id)wObject;

+(void)postNotificationWithTpye:(NSString*)type
                           info:(NSDictionary*)info;
@end