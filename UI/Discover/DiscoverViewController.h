//
//  HomeViewController.h
//  TB
//
//  Created by zucknet on 13/6/6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "BaseViewController.h"
#import "TBSeachBar.h"
#import "TMQuiltView.h"
#import "QBRefreshControl.h"
@class HomeAPIParms;
@interface DiscoverViewController : BaseViewController<TMQuiltViewDataSource,TMQuiltViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,QBRefreshControlDelegate>
{
    int count;
    NSMutableArray * discoverData;
    NSString *testImg;
    int  page;
    HomeAPIParms * parmas ;
    TBSeachBar *_seachBar;
    NSMutableArray *disImageData;
    BOOL isGetData;
}
@property (nonatomic, strong) TMQuiltView *quiltView;
@property(nonatomic,strong)TBSeachBar *seachBar;
@end
