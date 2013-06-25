//
//  HomeViewController.h
//  TB
//
//  Created by zucknet on 13/6/6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "BaseViewController.h"
#import "TMQuiltView.h"
#import "QBRefreshControl.h"
@class HomeAPIParms;
@interface HomeViewController : BaseViewController<TMQuiltViewDataSource,TMQuiltViewDelegate,UIScrollViewDelegate,QBRefreshControlDelegate>
{
    int count;
    NSMutableArray * homeData;
    NSMutableArray * homeImageData;

    NSString *testImg;
    int  page;
    HomeAPIParms * parmas ;
    BOOL isGetData;
}
@property (nonatomic, strong) TMQuiltView *quiltView;
@end
