//
//  WebViewViewController.h
//  TB
//
//  Created by kimilee on 13-6-20.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView * _web;
   }
@property(nonatomic,strong)UIWebView * web;
@property(nonatomic,strong) NSString *loadURL;

@end
