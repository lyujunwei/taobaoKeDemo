//
//  WaterFlowViewCell.m
//  WaterFlowStyle
//
//  Created by siqin.ljp on 12-5-16.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "WaterFlowViewCell.h"
#import "QuartzCore/QuartzCore.h"
@implementation WaterFlowViewCell

@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize indexPath = _indexPath;

@synthesize imageView = _imageView;

-(id)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        self.reuseIdentifier = identifier;
        self.clipsToBounds = YES;
        self.imageView = [[[UIImageView alloc] init] autorelease];
        
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        [self.imageView addGestureRecognizer:singleTap];//点击图片事件
        //[self.imageView setBackgroundColor:[UIColor lightGrayColor]];
        //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //self.imageView.clipsToBounds = YES;
    }
    return self;
}
-(void)clickImage
{
    LOG(@"click Image itemID:%d",self.itemID);
    UIViewController * vvc = [[UIViewController alloc]init];
    [self.vc.navigationController pushViewController:vvc animated:YES];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    if (!self.imageView.superview) {
        CGRect rect = self.frame;
        rect.origin.x = rect.origin.y = 0.0f;
        self.imageView.frame = rect;
        [self addSubview:self.imageView];
    }
}
@end
/* ************************************************** */
@implementation WFIndexPath

@synthesize column = _column;
@synthesize row = _row;

+ (WFIndexPath *)indexPathForRow:(NSInteger)row inColumn:(NSInteger)column
{
    WFIndexPath *indexPath = [[[WFIndexPath alloc] init] autorelease];
    
    indexPath.column = column;
    indexPath.row = row;
    
    return indexPath;
}

@end
