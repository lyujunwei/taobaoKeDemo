//
//  UIImageView+WebCach.m
//  Loadimage
//
//  Created by zucknet on 13/4/14.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "UIImageView+WebCach.h"

@implementation UIImageView (WebCach)

-(void)setImageWithURL:(NSURL *)url{
    dispatch_queue_t queque =  dispatch_queue_create("loadImage", NULL);
    dispatch_async(queque, ^{
       //加载网络数据
        
        NSData *data =[NSData dataWithContentsOfURL:url];
        UIImage *image= [UIImage imageWithData:data];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.image = image; //最好回到主线程操作

        });
    });
}

@end
