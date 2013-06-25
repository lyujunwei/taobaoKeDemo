//
//  UIImageView+OnlineImage.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "UIImageView+OnlineImage.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImageView (OnlineImage)
@dynamic  isFirstload;

-(void)setIsFirstload:(NSString *)isFirstload
{
    //self.isFirstload = isFirstload;
    
}

-(NSString *)isFirstload
{
  //  return self.isFirstload;
}
//-(BOOL)getIsFirstload{
//    return self.isFirstload;
//}
- (void)setOnlineImage:(NSString *)url
{
    [self setOnlineImage:url placeholderImage:nil];
}

- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image
{
    self.image = image;
    
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

#pragma mark -
#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //if (self.isFirstload==YES) {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 1 ;  // 动画持续时间(秒)
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionFade;//淡入淡出效果
            [self.layer addAnimation:animation forKey:@"animation"];
          //  [self setIsFirstload:NO];
       // }
        self.image = image;
     //   [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:2];
    });
}
-(void)downFinish
{
}


@end
