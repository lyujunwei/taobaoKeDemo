//
//  TBApiManage.m
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "TBApiManage.h"
#import "TopIOSClient.h"
#import "TopAppConnector.h"
#import "TopAppService.h"
#import "JSONKit.h"
#import "TBitem.h"
#import "AppUtility.h"
#import "TopServiceError.h"
#import "HomeAPIParms.h"
#import "AppGCDManage.h"
#import "AsyncImageDownloader.h"
#import "ASIHTTPRequest.h"
@implementation TBApiManage
@synthesize iosClinet = _iosClinet;
@synthesize homeParmas = _homeParmas;
@synthesize discoverParmas = _discoverParmas;
+(TBApiManage *)instance
{
    static TBApiManage *tbApiManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tbApiManage == nil) {
            tbApiManage = [[super allocWithZone:nil] init];
            [tbApiManage setClient];
        }
    });
    return tbApiManage;
}
+(void)initTopIOSClient
{
    TopIOSClient *topIOSClient = [TopIOSClient registerIOSClient:kAppkey appSecret:kAppsecretcode callbackUrl:kCallbackUrl needAutoRefreshToken:TRUE];
    [TopAppConnector registerAppConnector:kAppkey topclient:topIOSClient];
}

-(BOOL)setClient
{
    self.iosClinet =  [TopIOSClient getIOSClientByAppKey:kAppkey];
    if (!self.iosClinet) {
        return NO;
        DebugLog(@"iocClinet set error");
    }
    return YES;
}
-(NSString *)getNetWorkStatus
{
    DebugLog(@"%@",[self.iosClinet getCurrentNetWorkStatus]);
    return [self.iosClinet getCurrentNetWorkStatus];
}

+(TopIOSClient*)getTopIOSClient
{
    return [TopIOSClient getIOSClientByAppKey:kAppkey];
}

-(void)requestTBApi:(NSDictionary*)parmas
                        isByMainCallBack:(BOOL)isByMainCallBack
                        userId:(NSString * )userId
                        apiType:(ApiType)tpye
{
    SEL s ;
    switch (tpye) {
        case callBackByTmallSeachDiscoverApi:
            s = @selector(tmallSeachDiscoverApiResponse:);
            break;
        case callBackByTmallSeachHomeApi:
            s =@selector(tmallSeachHomeApiResponse:);
            break;
    }
        [_iosClinet api:@"POST" params:parmas target:self cb:s userId:userId needMainThreadCallBack:isByMainCallBack];
}
-(NSData*)getDataWithJson:(id)data
{
    if ([data isKindOfClass:[TopApiResponse class]])
    {
        TopApiResponse *response = (TopApiResponse *)data;
        if ([response content])
        {

            NSString *responseString = [response content];
            data =[responseString dataUsingEncoding:NSUTF8StringEncoding];
            return data;
        }
        else{
            DebugLog(@"response Error:%@",response.error);
            LOG(@"error code :%ld",(long)response.error.code);
            if (response.error.code == -1009) {
                LOG(@"网络错误")
                [AppUtility postNotificationWithTpye:TMALL_SEACH_NOTIF_NONETWORK info:nil];
            }
        }
    }
    return nil;
}
-(void)tmallSeachDiscoverApiResponse:(id)data
{
    data = [self getDataWithJson:data];
    NSDictionary *dict = [[[[data objectFromJSONData]objectForKey:@"tmall_items_search_response"]objectForKey:@"item_list"]objectForKey:@"tmall_search_item"];
    if (dict) {
        [AppGCDManage ManageBackThread:^{
            if ([[[AppUtility instance]discoverData]count]<=0) {
                [[[AppUtility instance]discoverImageHight]removeAllObjects];
            }
            for (NSDictionary * dic in dict)
            {
                TBitem * item  = [TBitem instancefromJsonDic:dic];
                NSNumber * hight = [[NSNumber alloc]initWithInt:100+arc4random()%60];
                [[[AppUtility instance]discoverImageHight]addObject:hight];
                [[[AppUtility instance]discoverData]addObject:item];
                // [img setValue:@"1" forKey:@"kind"];
               // [self setOnlineImage:item.pic_path placeholderImage:img];
            }
            LOG(@"disData %d object did Append",[[[AppUtility instance]discoverData] count]);
            [AppUtility postNotificationWithTpye:TMALL_SEACH_DISCOVER_NOTIF info:nil];
        }];
    }
    else
    {
        LOG(@"NO Data");
        if (![[self getNetWorkStatus]isEqualToString:NetWorkNoNetWorkStatus]) {
            [AppUtility postNotificationWithTpye:TMALL_SEACH_NOTIF_NODATA info:nil] ;
        }
    }
}
-(void)tmallSeachHomeApiResponse:(id)data
{
        data = [self getDataWithJson:data];
        NSDictionary *dict = [[[[data objectFromJSONData]objectForKey:@"tmall_items_search_response"]objectForKey:@"item_list"]objectForKey:@"tmall_search_item"];
        if (dict) {
            [AppGCDManage ManageBackThread:^{
                for (NSDictionary * dic in dict)
                {
                    TBitem * item  = [TBitem instancefromJsonDic:dic];
                    NSNumber * hight = [[NSNumber alloc]initWithInt:100+arc4random()%60];
                    [[[AppUtility instance]homeImageHight]addObject:hight];
                    [[[AppUtility instance]homeData]addObject:item];
                }
                LOG(@"homeData %d object did Append",[[[AppUtility instance]homeData] count]);
                [AppUtility postNotificationWithTpye:TMALL_SEACH_HOME_NOTIF info:nil];
            }];
    }
    else
    {
        LOG(@"NO Data");
        if (![[self getNetWorkStatus]isEqualToString:NetWorkNoNetWorkStatus]) {
            [AppUtility postNotificationWithTpye:TMALL_SEACH_NOTIF_NODATA info:nil] ;
        }
    }
}

//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://test.guo7.com/alimama/?url=%@",[NSString getURLcodeString:item.url]]];
//    ASIHTTPRequest * req = [[ASIHTTPRequest alloc]initWithURL:url];
//    [req setDelegate:self];
//    [req startAsynchronous];
//    NSData *data = request.responseData;
//    
//    NSDictionary *dic = [data objectFromJSONData];
//    NSLog(@"dic%@",dic);
//}
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    LOG(@"failed:%@",request.error);
//}
-(void)getTmallSeachHomeDataByPage:(NSNumber*)page
{
    if (self.homeParmas) {
        [self.homeParmas setStart:page.stringValue];
        [[TBApiManage instance]requestTBApi:self.homeParmas isByMainCallBack:YES userId:nil apiType:callBackByTmallSeachHomeApi];
    }
}
-(void)getTmallSeachDiscoverDataByPage:(NSNumber*)page
{
    if (self.discoverParmas) {
        [self.discoverParmas setStart:page.stringValue];
        [[TBApiManage instance]requestTBApi:self.discoverParmas isByMainCallBack:YES userId:nil apiType:callBackByTmallSeachDiscoverApi];
    }
}

- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image
{
    //self.image = image;
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

#pragma mark -
#pragma mark - AsyncImageDownloader Delegate
//
//- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
//{
//    image = [self getImageFromImage:image];
//   // dispatch_async(dispatch_get_main_queue(), ^{
//      //  if ([[image valueForKey:@"kind"]isEqualToString:@"1"]) {
//            [[[AppUtility instance]discoverImagerData]addObject:image];
//        //}
//        //   [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:2];
//   // });
//}
//
//-(UIImage *)getImageFromImage:(UIImage*)image{
//    
//    //大图bigImage
//    
//    //定义myImageRect，截图的区域
//    int x =100+ arc4random() % 60;
//    int y = 100+arc4random() % 60;
//
//    CGRect myImageRect = CGRectMake(0, 0, x, y);
//        
//    CGImageRef imageRef = image.CGImage;
//    
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
//    
//    
//    CGSize size;
//    
//    size.width = 57.0;
//    
//    size.height = 57.0;
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, myImageRect, subImageRef);
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
//    return smallImage;  
//    
//}
@end