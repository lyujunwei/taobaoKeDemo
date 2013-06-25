//
//  itemDetailViewController.m
//  TB
//
//  Created by imzucknet on 13/6/14.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "itemDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCach.h"

@interface itemDetailViewController ()

@end

@implementation itemDetailViewController

-(void)loadView
{
    [super loadView];
    
    [self _initNavigationbar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,44, self.view.frame.size.width, self.view.frame.size.height - 88.0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.tag = 101;
    [self.view addSubview:self.tableView];
    
    self.itemBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    self.itemBuy.frame = CGRectMake(180, 51, 140, 35);
    [self.itemBuy setImage:[UIImage imageNamed:@"itemBuyicon"] forState:UIControlStateNormal];
    [self.tableView addSubview:self.itemBuy];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(12, 30, 296, 92)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(1370, 92);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 102;
    self.scrollView.delegate = self;
    
}

-(void)_initNavigationbar {
        
    self.navigationController.navigationBarHidden = YES;
    
    _navigationbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UIImageView *navImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navImage.image = [UIImage imageNamed:@"navigationTop"];
    [_navigationbar addSubview:navImage];
    
    [self.view addSubview:_navigationbar];
    
    UIImage* image= [UIImage imageNamed:@"backbtn"];
    UIButton* backButton= [[UIButton alloc] init];
    backButton.frame = CGRectMake(0, 5, 60, 35);
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backVc) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 60, 35)];
    lab.text = @"返回";
    lab.font = [UIFont boldSystemFontOfSize:12.0f];
    lab.textColor = [UIColor colorWithRed:247.0/255.0 green:81.0/255.0 blue:113.0/255.0 alpha:1.0];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.backgroundColor = [UIColor clearColor];
    [backButton addSubview:lab];
    
    [_navigationbar addSubview:backButton];
    
    
    UIImage* homeimage= [UIImage imageNamed:@"backhome"];
    UIButton* homeButton= [[UIButton alloc] init];
    homeButton.frame = CGRectMake(229, 5, 91, 35);
    [homeButton setBackgroundImage:homeimage forState:UIControlStateNormal];
    [homeButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationbar addSubview:homeButton];
    
    self.tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
    self.tabbar.backgroundImage = [UIImage imageNamed:@"itembar"];
    [self.view addSubview:self.tabbar];
    
    UIButton *btn1= [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 14, 20, 20);
    [btn1 setImage:[UIImage imageNamed:@"createbtn"] forState:UIControlStateNormal];
    [self.tabbar addSubview:btn1];
    
    UIButton *btn2= [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(150, 14, 20, 20);
    [btn2 setImage:[UIImage imageNamed:@"likebtn"] forState:UIControlStateNormal];
    [self.tabbar addSubview:btn2];
    
    UIButton *btn3= [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(280, 14, 20, 20);
    [btn3 setImage:[UIImage imageNamed:@"sharebtn"] forState:UIControlStateNormal];
    [self.tabbar addSubview:btn3];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        
    switch (indexPath.row) {
        //标题
        case 0: {
            UIImageView *imagePath = (UIImageView *)[cell.contentView viewWithTag:101];
            imagePath.frame = CGRectMake(0, 0, 320, 44);
            imagePath.image = [UIImage imageNamed:@"itemDetailTop"];
            
            UILabel *lab = (UILabel *)[cell.contentView viewWithTag:102];
            lab.numberOfLines = 1;
            lab.text = @"耐克NIKE男鞋 AIR MAX 专柜正品全掌气垫跑鞋运动鞋487982-436";
            lab.textAlignment = NSTextAlignmentCenter;
            lab.frame = CGRectMake(10, 0, 300, 44);
        }
            break;
            
        //获取图片url.
        case 1:
        {
            UIView *view =[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)];
            view.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:view];

            
            self.itemImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 298, 298)];
            NSURL *url = [NSURL URLWithString:@"http://img03.taobaocdn.com/bao/uploaded/i3/18287023916755131/T1_QSWXB4fXXXXXXXX_!!0-item_pic.jpg_160x160.jpg"];
            [self.itemImage setImageWithURL:url];
            self.itemImage.userInteractionEnabled = YES;
            [view addSubview:self.itemImage];
            
        
        }
            break;
        //单独放置图片介绍
        case 2:
        {
            UIImageView *imagePath = (UIImageView *)[cell.contentView viewWithTag:101];
            imagePath.frame = CGRectMake(0, 0, 320, 52);
            imagePath.image = [UIImage imageNamed:@"itemInfo"];
            
            UILabel *lab = (UILabel *)[cell.contentView viewWithTag:102];
            lab.text = @"aaaaaaaa";
            lab.frame = CGRectMake(40, 0, 320, 52);
            
        }
            break;
        //可能还会感兴趣
        case 3:
            
        {

            UIImageView *imagePath = (UIImageView *)[cell.contentView viewWithTag:101];
            imagePath.frame = CGRectMake(0, 0, 320, 130);
            imagePath.image = [UIImage imageNamed:@"itemLikeBackground"];
            
            [cell.contentView addSubview:self.scrollView];
            
            for (int i = 0; i < 16 ; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(5+(i*85), 5, 80, 80);
                button.tag = i;
                [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollView addSubview:button];
                
            }
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)selectButton:(UIButton *)button {
    
    switch (button.tag) {
            /*          方法            */
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 44;
            break;
        case 1:
            return  300;
            break;
        case 2:
            return 52;
            break;
        case 3:
            return 130;
            break;
    }
    return indexPath.row;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    switch (scrollView.tag) {
        case 101:
            if (scrollView.contentOffset.y >=  48 ) {
                self.itemBuy.frame = CGRectMake(180, 4, 140, 35);
                [self.view addSubview:self.itemBuy];
            }   else {
                self.itemBuy.frame = CGRectMake(180, 51, 140, 35);
                [self.tableView addSubview:self.itemBuy];
            }
            break;
    case 102:
            
            break;
    }
}

-(void)backVc{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
