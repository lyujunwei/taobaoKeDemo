//
//  itemDetailViewController.h
//  TB
//
//  Created by imzucknet on 13/6/14.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    NSArray *items;
    UIView *_navigationbar;
//    UIToolbar *_toolbar;
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *itemBuy;
@property(nonatomic,strong)UIImageView *itemImage;
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,strong)UITabBar *tabbar;

@end
