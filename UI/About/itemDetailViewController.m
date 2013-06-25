//
//  itemInfoDetailViewController.m
//  TB
//
//  Created by imzucknet on 13/6/19.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "itemDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "HomeAPIParms.h"
#import "TBitem.h"
#import "AppUtility.h"
#import "AppGCDManage.h"
#import "UIImageView+OnlineImage.h"
#import "ASIHTTPRequest.h"
#import <QuartzCore/QuartzCore.h>
#define TBKURL @"http://www.guo7.com/alimama/?url="
#import "JSONKit.h"
#import "WebViewViewController.h"
#import "NSString+utility.h"
@interface itemDetailViewController ()
{
    NSMutableArray *imageViews;
}
@end

@implementation itemDetailViewController
@synthesize item=_item;

-(void)loadView
{
    [super loadView];
    self.navigationController.navigationBarHidden = YES;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height  )];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.tag = 101;
    [self.view addSubview:self.tableView];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(12, 30, 296, 92)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(690, 92);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 102;
    self.scrollView.delegate = self;
    imageViews = [[NSMutableArray alloc]init];
    for (int i = 0; i < 8 ; i++) {
        UIButton * imageButton = [[UIButton alloc]init];
        imageButton.frame = CGRectMake(5+(i*85), 5, 80, 80);
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        [imageButton addTarget:self action:@selector(cliack:) forControlEvents:UIControlEventTouchDown];
        [iv setTag:999];
        [imageButton setBackgroundColor:[UIColor clearColor]];
        [imageButton addSubview:iv];
        [self.scrollView addSubview:imageButton];
        [imageViews addObject:imageButton];
    }
    UIButton* backButton= [[UIButton alloc] init];
    backButton.frame = CGRectMake(10, 7, 30, 30);
    [backButton setBackgroundImage: [UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [backButton setBackgroundImage: [UIImage imageNamed:@"back2"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backVc) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel * lb = [[UILabel alloc]init];
    [self.tableView addSubview:lb];
    [lb setBackgroundColor:[UIColor clearColor]];
    [lb setFrame:CGRectMake(20, 428, 120, 30)];
    [lb setFont:[UIFont fontWithName:[[UIFont familyNames] objectAtIndex:0] size:12]];
    [lb setTextColor:[UIColor lightGrayColor]];
    [lb setText:@"猜你喜欢的"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *oneFingerSwipeDown =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backVc)] ;
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:oneFingerSwipeDown];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.tableView setContentOffset:CGPointMake(0, 0)];


    [self.tableView reloadData];
    NSMutableArray *arr = [AppUtility getRandomNumber:[[[AppUtility instance] homeData] count]];
    
    for (int a= 0 ; a<imageViews.count; a++) {
        
        UIButton * button = [imageViews objectAtIndex:a];
        UIImageView *iv = (UIImageView * )[ button viewWithTag:999];
        NSNumber * i = [arr objectAtIndex:a];
        TBitem * item = [[[AppUtility instance]homeData]objectAtIndex:i.intValue];
        [button setTag:i.intValue];
        [iv setOnlineImage:item.pic_path];
        
        //LOG(@"arr:%@",[NSString getLImageUrl:item.pic_path]);

    }
    
    

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 101;
        [cell.contentView addSubview:imageView];
        
        
        UILabel *lab = [[UILabel alloc]init];
        lab.tag = 102;
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines = 2;
        [cell.contentView addSubview:lab];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 103;
        button.frame = CGRectMake(0, 0, 320, 51);
        [cell.contentView addSubview:button];

    }
    
    switch (indexPath.row) {
            //标题
        case 0:
        {
            UIImageView *imagePath = (UIImageView *)[cell.contentView viewWithTag:101];
            imagePath.frame = CGRectMake(0, 0, 320, 320);
           // [imagePath setImageWithURL:[NSURL URLWithString:_item.pic_path]];
            [imagePath setOnlineImage:[NSString getLImageUrl:_item.pic_path]];
        }
            break;
        case 1:
        {
            UILabel *lab = (UILabel *)[cell.contentView viewWithTag:102];
            lab.numberOfLines = 1;
            lab.text = _item.title;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.frame = CGRectMake(10, 0, 300, 45);
        }
            break;
            //单独放置图片介绍
            //购买
        case 2:
        {
            UIButton *toTaobao = [UIButton buttonWithType:UIButtonTypeCustom];
            toTaobao.frame = CGRectMake(23-5, 5, 174, 43);
            [toTaobao setImage:[UIImage imageNamed:@"totaobao"] forState:UIControlStateNormal];
            [toTaobao setImage:[UIImage imageNamed:@"totaobao2"] forState:UIControlStateSelected];
            
            //去购买URL
            [toTaobao addTarget:self action:@selector(getTBKURL) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:toTaobao];
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 174, 43)];
            lab1.text = [NSString stringWithFormat:@"¥%@ 去购买", _item.price_with_rate];
            
            lab1.textAlignment=NSTextAlignmentCenter;
            lab1.textColor = [UIColor whiteColor];
            lab1.font = [UIFont boldSystemFontOfSize:20.0f];
            lab1.backgroundColor = [UIColor clearColor];
            [toTaobao addSubview:lab1];
            
            UIButton *tofavv = [UIButton buttonWithType:UIButtonTypeCustom];
            tofavv.frame = CGRectMake(207+5, 5, 90, 43);
            [tofavv setImage:[UIImage imageNamed:@"tofav"] forState:UIControlStateNormal];
            [tofavv setImage:[UIImage imageNamed:@"tofac2"] forState:UIControlStateSelected];
            
            //发送参数到收藏
            [tofavv addTarget:self action:@selector(sendItemfav) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:tofavv];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 43)];
            lab2.text = @"收藏";
            lab2.font = [UIFont boldSystemFontOfSize:20.0f];
            lab2.textAlignment=NSTextAlignmentCenter;
            lab2.textColor = [UIColor whiteColor];
            lab2.backgroundColor = [UIColor clearColor];
            [tofavv addSubview:lab2];
            
        }
            break;
            //可能还会感兴趣
        case 3:
        {
            UIImageView *imagePath = (UIImageView *)[cell.contentView viewWithTag:101];
            imagePath.frame = CGRectMake(5, 10, 310, 120);
            [imagePath setBackgroundColor:[UIColor redColor]];
            [imagePath setAlpha:0.1];
            imagePath.layer.cornerRadius = 4;
            imagePath.layer.masksToBounds = YES;
          //  imagePath.image = [UIImage imageNamed:@"itemLikeBackground"];
            [cell.contentView addSubview:self.scrollView];
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(IBAction)cliack:(id)sender
{
    UIButton * b = sender;
    TBitem * tt = [[[AppUtility instance]homeData]objectAtIndex:b.tag];
    itemDetailViewController * vc = [[itemDetailViewController alloc]init];
    [vc setItem:tt];
    [self.navigationController pushViewController:vc animated:YES];
    LOG(@"url:%@",tt.pic_path);

}
#pragma mark -保存item的值到数据库 (Coredata)
-(void)sendItemfav
{
    
    NSLog(@"%@",_item);
    
    NSDictionary *dic = @{@"title":_item.title,@"fast_post_fee":_item.fast_post_fee,@"is_cod":_item.is_cod,@"is_promotion":_item.is_promotion,@"item_id":_item.item_id,@"location":_item.location,@"nick":_item.pic_path,@"pic_path":_item.pic_path,@"price":_item.price,@"price_with_rate":_item.price_with_rate,@"seller_loc":_item.seller_loc,@"shipping":_item.shipping,@"sold":_item.sold,@"spu_id":_item.spu_id,@"url":_item.url,@"user_id":_item.user_id};
    
    NSMutableArray *bookmarkArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"bookmark"] mutableCopy];
    if (!bookmarkArray)
        bookmarkArray = [NSMutableArray array];
    [bookmarkArray addObject:dic];
    
    [[NSUserDefaults standardUserDefaults] setObject:[bookmarkArray copy]forKey:@"bookmark"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    favlab.text = @"已收藏";
    tofav.enabled = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 320;
            break;
        case 1:
            return  45;
            break;
        case 2:
            return 55;
            break;
        case 3:
            return 130;
            break;
    }
    return indexPath.row;
}

-(void)backVc{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTBKURL
{
    NSLog(@"getURL:%@",[NSString stringWithFormat:@"%@%@",TBKURL,[NSString getURLcodeString:self.item.url]]);
    ASIHTTPRequest * req  = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TBKURL,[NSString getURLcodeString:self.item.url]]]];
    [req setDelegate:self];
    [req startAsynchronous];
    
//    WebViewViewController * web = [[WebViewViewController alloc]init];
//    web.loadURL = self.item.url;
//    [self.navigationController pushViewController:web animated:YES];
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{    LOG(@"dic:%@",request.responseString);

    NSDictionary * dci = [request.responseData objectFromJSONData];
    LOG(@"dic:%@",dci);
    NSString * url = [dci objectForKey:@"url"];
    if (url)
    {
        [AppGCDManage ManageMainThread:^{
                        
            WebViewViewController * web = [[WebViewViewController alloc]init];
            web.loadURL = self.item.url;
            [self.navigationController pushViewController:web animated:YES];
        
        }];

    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [AppUtility showMassage:@"网络连接错误"];
    
    [self performSelector:@selector(disMassage) withObject:self afterDelay:2];
}
-(void)disMassage
{
    [AppUtility unshowMassage];
}

@end
