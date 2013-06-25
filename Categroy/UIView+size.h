//
//  UIView+size.h
//  TB
//
//  Created by kimilee on 13-6-14.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (size)
- (void)setHeight:(CGFloat)height;

+ (CGRect)mainFrame;

- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (void)setLeft:(CGFloat)left;
- (void)setBottom:(CGFloat)bottom;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (void)setOrigin:(CGPoint)point;

@end
