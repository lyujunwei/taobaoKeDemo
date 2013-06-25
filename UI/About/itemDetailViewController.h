//
//  itemInfoDetailViewController.h
//  TB
//
//  Created by imzucknet on 13/6/19.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@class TBitem;

@interface itemDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>{
    UIView *_navigationbar;
    TBitem * _item;
    NSArray *items;
    UIButton *tofav;
    UILabel *favlab;


}

@property(nonatomic,strong)TBitem *item;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *itemImage;

@end