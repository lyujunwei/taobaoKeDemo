//
//  RefreshView.m
//  TB
//
//  Created by kimilee on 13-6-19.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "RefreshView.h"

#import "QBAnimationSequence.h"
#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"
@interface RefreshView ()
{
    QBAnimationSequence *_sequence;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,) CGFloat angle;

@end
@implementation RefreshView

- (id)init
{
    self = [super init];
    
    if(self) {
        self.frame = CGRectMake(0, 0, 320, 45);
        self.threshold = -45;
        
        self.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
        
        self.angle = 0;
        
        // 画像
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(146, 10, 28, 28)];
        imageView.image = [UIImage imageNamed:@"sync.png"];
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        // QBAnimationSequence
        QBAnimationItem *item = [QBAnimationItem itemWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI/2);
        }];
        
        QBAnimationGroup *group = [QBAnimationGroup groupWithItems:@[item]];
        
        _sequence = [[QBAnimationSequence alloc] initWithAnimationGroups:@[group] repeat:YES];
        
    }
    
    return self;
}
- (void)setState:(QBRefreshControlState)state
{
    [super setState:state];
    
    switch(state) {
        case QBRefreshControlStateHidden:
            break;
        case QBRefreshControlStatePullingDown:
        case QBRefreshControlStateOveredThreshold:
        {
            CGPoint contentOffset = self.scrollView.contentOffset;
            
            CGFloat angle = contentOffset.y * 180.0 / M_PI * 0.001;
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, self.angle - angle);
            self.angle = angle;
        }
            break;
            case QBRefreshControlStateStopping:
            break;
    }
}

- (void)beginRefreshing
{
    [super beginRefreshing];
    
    [_sequence start];
}

- (void)endRefreshing
{
    [super endRefreshing];
    
    [_sequence stop];
}

@end
