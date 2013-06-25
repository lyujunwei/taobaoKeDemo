//  TBApiManage.h
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
#import <Foundation/Foundation.h>
#import "AsyncImageDownloader.h"
#import "ASIHTTPRequest.h"
@class TopIOSClient;
@class HomeAPIParms;

@interface TBApiManage : NSObject<AsyncImageDownloaderDelegate,ASIHTTPRequestDelegate>
{
    HomeAPIParms *_homeParmas;
    TopIOSClient * _iosClinet;
    HomeAPIParms *_discoverParmas;
}

typedef  enum {
    callBackByTmallSeachDiscoverApi,
    callBackByTmallSeachHomeApi
}ApiType;

@property(strong)HomeAPIParms *discoverParmas;
@property(strong)HomeAPIParms *homeParmas;
@property(strong)TopIOSClient * iosClinet;
+(TBApiManage *)instance;
+(void)initTopIOSClient;
+(TopIOSClient*)getTopIOSClient;

-(void)getTmallSeachHomeDataByPage:(NSNumber*)page;
-(void)getTmallSeachDiscoverDataByPage:(NSNumber*)page;

//获取当前网络状态
-(NSString *)getNetWorkStatus;
//AIP接口
-(void)requestTBApi:(NSDictionary*)parmas
   isByMainCallBack:(BOOL)isByMainCallBack
             userId:(NSString * )userId
            apiType:(ApiType)tpye;

@end
