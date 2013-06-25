//
//  HomeViewController.m
//  TB
//
//  Created by zucknet on 13/6/6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "DiscoverViewController.h"
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
#define NUMBER_OF_COLUMNS 3
#define TAB_NAV_HIGHT 90
#define ADD_PAGE 100
#define DEFAULT_SEARCH_NAME @"裙子"
#define SEARCHBAR_HIGHT 40
#import "RefreshView.h"

@interface DiscoverViewController ()
{
      UIButton * back;
}
@property (nonatomic, strong) RefreshView *myRefreshControl;
@end
@implementation DiscoverViewController
@synthesize seachBar= _seachBar;
-(void)discoverfinishLoadData
{
    [AppGCDManage ManageMainThread:^
     {
         discoverData = [[AppUtility instance]discoverData];
         if (discoverData.count>0) {
             LOG(@"data count%d",discoverData.count);
             isGetData =NO;
             [self.quiltView reloadData];
             [self disMassage];
             [_quiltView setHidden:NO];

         }
         else
         {
             LOG(@"NoData")
             //[self.quiltView setHidden:YES];
         }
     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    discoverData = [[AppUtility instance]discoverData];
    //NSString * seachName = [NSString getURLcodeString:DEFAULT_SEARCH_NAME];
    parmas = [[HomeAPIParms alloc]initWithBaseParamsMethod:TMALL_ITEM_SEACH_API SeachName:nil start:0];
    [parmas setPage_size:@"100"];
    [[TBApiManage instance]setDiscoverParmas:parmas];
    //[[TBApiManage instance]getTmallSeachDiscoverDataByPage:[NSNumber numberWithInt:0]];
    //[AppUtility showMassage:@"正在加载"];

}
-(void)addData
{
    page = page+ADD_PAGE;
    [[TBApiManage instance]getTmallSeachDiscoverDataByPage:[NSNumber numberWithInt:page]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"搜索";
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(discoverfinishLoadData) name:TMALL_SEACH_DISCOVER_NOTIF object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNoDataMassage) name:TMALL_SEACH_NOTIF_NODATA object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showNoNetWorkMassage) name:TMALL_SEACH_NOTIF_NONETWORK object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addData) name:TMALL_SEACH_DISCOVER_GET_NOTF object:nil];
        testImg =    @"http://img.topit.me/l/201008/11/12815218412635.jpg";
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    isGetData =NO;
    [AppUtility unshowMassage];
}
-(void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"searchbg"]]];
    _seachBar = [[TBSeachBar alloc]initWithFrame:CGRectMake(0, 0, 320, SEARCHBAR_HIGHT)];
    [self.view addSubview:_seachBar];
    [_seachBar setDelegate:self];
    
    _quiltView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, SEARCHBAR_HIGHT, self.view.width, self.view.height-SEARCHBAR_HIGHT)];
    _quiltView.delegate = self;
    _quiltView.dataSource = self;
    _quiltView.decelerationRate=0.5;

    [_quiltView setShowsHorizontalScrollIndicator:NO];
    [_quiltView setShowsVerticalScrollIndicator:NO];
   [_quiltView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    //[_quiltView setBackgroundColor:[UIColor orangeColor]];
    _quiltView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    RefreshView *refreshControl = [[RefreshView alloc] init];
    refreshControl.delegate = self;
    self.myRefreshControl = refreshControl;
    [_quiltView addSubview:refreshControl];
    [_quiltView setHidden:YES];
    [self.view addSubview:_quiltView];
    
    [self.navigationController.navigationBar setHidden:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [[self tabBarItem]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (!back) {
        back = [[UIButton alloc]initWithFrame:CGRectMake(0, SEARCHBAR_HIGHT, self.view.width, self.view.height-SEARCHBAR_HIGHT)];
    }
    [back setBackgroundColor:[UIColor blackColor]];
    [back setAlpha:0.5];
    [back addTarget:self action:@selector(delBackView:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:back];
}
-(IBAction)delBackView:(id)sender
{
    [self.seachBar resignFirstResponder];
    [sender removeFromSuperview];
   // [self.seachBar setHidden:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [back removeFromSuperview];
    page = 0;
    [parmas setSeachName:[NSString getURLcodeString:searchBar.text]];
    [[[AppUtility instance]discoverData]removeAllObjects];
    [[TBApiManage instance]getTmallSeachDiscoverDataByPage:[NSNumber numberWithInt:page]];
    LOG(@"seach:%@",searchBar.text);
    [_seachBar resignFirstResponder];
    [_quiltView reloadData];
    [_quiltView setHidden:YES];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    if (discoverData)
    {
        return discoverData.count;
    }
    else
    return 0;
}
#pragma mark - TMQuiltViewDataSource
- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMQuiltViewCell *cell = [self.quiltView dequeueReusableCellWithReuseIdentifier:nil];
    if (!cell) {
        cell = [[TMQuiltViewCell alloc] initWithReuseIdentifier:nil];
    }
    TBitem * item  = [discoverData objectAtIndex:indexPath.row];
    if (item) {
    }
    [cell.photoView setOnlineImage:[NSString getSImageUrl:item.pic_path]];
    [cell setVc:self];
    [cell setItem:item];
    NSString *str = [NSString stringWithFormat:@"￥%@",item.price_with_rate];
    cell.titleLabel.text =str;
        return cell;
}
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {

    if (discoverData) {
        NSNumber * n = [[[AppUtility instance]discoverImageHight]objectAtIndex:indexPath.row];
        return n.intValue;
    }
    else return 0;
}
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return 3;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isGetData==NO&&scrollView.contentOffset.y>scrollView.contentSize.height-400) {
        isGetData = YES;
        LOG(@"getData");
        [self addData];
        [AppUtility showMassage:@"正在加载"];
    }
}
#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    LOG(@"load");
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
        [[TBApiManage instance]getTmallSeachDiscoverDataByPage:[NSNumber numberWithInt:0]];
    });
}
@end
