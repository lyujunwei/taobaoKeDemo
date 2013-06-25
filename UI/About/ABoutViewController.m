//
//  ABoutViewController.m
//  TB
//
//  Created by kimilee on 13-6-19.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "ABoutViewController.h"

@interface ABoutViewController ()
@end

@implementation ABoutViewController

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
}
-(void)loadView
{
    [super loadView];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1]];
    UIImageView *backView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-59)];
    [backView setImage:[UIImage imageNamed:@"aboutImage"]];
    [self.view addSubview:backView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
