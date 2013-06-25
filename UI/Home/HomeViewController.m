//
//  HomeViewController.m
//  TB
//
//  Created by zucknet on 13/6/6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+size.h"
#import "TBApiManage.h"
#import "AppUtility.h"
#import "HomeAPIParms.h"
#import "TBitem.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+OnlineImage.h"
#import "AppGCDManage.h"
#import "TMQuiltView.h"
#import "TMQuiltViewCell.h"
#import "RefreshView.h"
#define NUMBER_OF_COLUMNS 3
#define TAB_NAV_HIGHT 90
#define SDC_HIGHT 44
#define ADD_PAGE 100
#define PHOTO_HIGHT 160
#define DEFAULT_SEARCH_NAME @"女装"

@interface HomeViewController ()
@property (nonatomic, strong) RefreshView *myRefreshControl;
@end
@implementation HomeViewController
-(void)finishLoadData
{
    [AppGCDManage ManageMainThread:^
    {
        
        homeData = [[AppUtility instance]homeData];
        // [self addData];
        //[self initData];
        if (homeData) {
            isGetData = NO;
            LOG(@"finishLoadData :%d",[[[AppUtility instance]homeData]count]);
            [_quiltView reloadData];
            [self disMassage];
        }
        else
        {
            LOG(@"LoadDataError");
        }
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
    
    homeData = [[AppUtility instance]homeData];
    NSString * seachName = [NSString getURLcodeString:DEFAULT_SEARCH_NAME];
    parmas = [[HomeAPIParms alloc]initWithBaseParamsMethod:TMALL_ITEM_SEACH_API SeachName:seachName start:0];
    [parmas setPage_size:@"100"];
    [[TBApiManage instance]setHomeParmas:parmas];
    [[TBApiManage instance]getTmallSeachHomeDataByPage:[NSNumber numberWithInt:0]];
    [AppUtility showMassage:@"正在加载"];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";

        testImg =    @"http://img.topit.me/l/201008/11/12815218412635.jpg";
    }
    return self;
}
-(void)showNoNetWorkMassage
{
    [AppUtility showMassage:@"网络不稳"];
    [self performSelector:@selector(disMassage) withObject:self afterDelay:1];
}
-(void)showNoDataMassage
{
    [AppUtility showMassage:@"没有数据更新"];
    [self performSelector:@selector(disMassage) withObject:self afterDelay:1];
}
-(void)disMassage
{
    [AppUtility unshowMassage];
}
-(void)loadView
{
    [super loadView];

    _quiltView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 1, self.view.width, self.view.height)];
    _quiltView.delegate = self;
    _quiltView.dataSource = self;
    [_quiltView setShowsHorizontalScrollIndicator:NO];
    [_quiltView setShowsVerticalScrollIndicator:NO];
    [_quiltView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];    _quiltView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _quiltView.decelerationRate=0.5;
    RefreshView *refreshControl = [[RefreshView alloc] init];
    refreshControl.delegate = self;
    self.myRefreshControl = refreshControl;
    [_quiltView addSubview:refreshControl];

    [self.view addSubview:_quiltView];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishLoadData) name:TMALL_SEACH_HOME_NOTIF object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNoDataMassage) name:TMALL_SEACH_NOTIF_NODATA object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNoNetWorkMassage) name:TMALL_SEACH_NOTIF_NONETWORK object:nil];

}


- (void)viewWillAppear:(BOOL)animated
{
    [[self tabBarItem]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    if (homeData) {
        return homeData.count;
    }
    else
        return 0;
}

#pragma mark - TMQuiltViewDataSource
- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMQuiltViewCell *cell = [self.quiltView dequeueReusableCellWithReuseIdentifier:nil];
    if (!cell) {
        cell = [[TMQuiltViewCell alloc] initWithReuseIdentifier:nil];
       // [cell.photoView setIsFirstload:YES];
        LOG(@"index:%d",cell.photoView.isFirstload);
    }
    //LOG(@"index:%d",indexPath.row);
    TBitem * item  = [homeData objectAtIndex:indexPath.row];
    [cell setVc:self];
    [cell setItem:item];
    [cell.photoView setOnlineImage:[NSString getSImageUrl:item.pic_path]];
    NSString *str = [NSString stringWithFormat:@"￥%@",item.price_with_rate];
    cell.titleLabel.text =str;
    return cell;
    
}
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    if (homeData) {
        NSNumber * n = [[[AppUtility instance]homeImageHight]objectAtIndex:indexPath.row];
        return n.intValue;
    }
    else return 0;
}
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return 3;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isGetData==NO&&scrollView.contentOffset.y>scrollView.contentSize.height-330) {
        isGetData = YES;
        LOG(@"getData");
        LOG(@"c:%f",scrollView.contentOffset.y);
        LOG(@"s:%f",scrollView.contentSize.height);
        [self addData];
        [AppUtility showMassage:@"正在加载"];
    }
}

-(void)addData
{
    page = page+ADD_PAGE;
    [[TBApiManage instance]getTmallSeachHomeDataByPage:[NSNumber numberWithInt:page]];
}

#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    LOG(@"load");
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [homeData removeAllObjects];
        [_quiltView reloadData];
        [[TBApiManage instance]getTmallSeachHomeDataByPage:[NSNumber numberWithInt:0]];
        [self.myRefreshControl endRefreshing];
    });
}
@end
