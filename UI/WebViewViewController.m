//
//  WebViewViewController.m
//  TB
//
//  Created by kimilee on 13-6-20.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController
@synthesize web = _web;
@synthesize loadURL;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_web setDelegate:self];
    [_web setFrame:CGRectMake(0, 40, 320, self.view.frame.size.height-40)];
    if (self.loadURL) {
        LOG(@"url :%@",self.loadURL);
        [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]]];
        [AppUtility showMassage:@"正在加载"];
    }
	// Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    _web = [[UIWebView alloc]init];
    UIView * bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [bar setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [self.view addSubview:bar];
    
    UIButton* backButton= [[UIButton alloc] init];
    backButton.frame = CGRectMake(10, 7, 30, 30);
    [backButton setBackgroundImage: [UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [backButton setBackgroundImage: [UIImage imageNamed:@"back2"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backVc) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, backButton.frame.size.height)];
    [lb setBackgroundColor:[UIColor clearColor]];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setFont:[UIFont fontWithName:[[UIFont familyNames]objectAtIndex:14] size:16]];
    [lb setTextColor:[UIColor orangeColor]];
    [lb setText:@"淘宝购买页面"];
    [backButton addSubview:lb];
    
    [self.view addSubview:backButton];
    
    
    [_web setScalesPageToFit:YES];
    [self.view addSubview:_web];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (self.loadURL) {
//    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]]];
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [AppUtility unshowMassage];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [AppUtility showMassage:@"网页连接错误"];
    [self performSelector:@selector(disMassage) withObject:self afterDelay:2];
}
-(void)disMassage
{
    [AppUtility unshowMassage];
}
-(void)dealloc
{
    
}
-(void)backVc{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
