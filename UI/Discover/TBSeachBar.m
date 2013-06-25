//
//  TBSeachBar.m
//  TB
//
//  Created by kimilee on 13-6-17.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "TBSeachBar.h"
@implementation TBSeachBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:@"search"]];
    }
    return self;
}
- (void)layoutSubviews {
    UITextField *searchField;
    NSUInteger numViews = [self.subviews count];
    for(int i = 0; i < numViews; i++) {
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            searchField = [self.subviews objectAtIndex:i];
        }
    }
    if(!(searchField == nil)) {
        searchField.textColor = [UIColor lightGrayColor];
        [searchField.leftView setHidden:YES];
        [searchField setBackground: nil ];
        [searchField setBorderStyle:UITextBorderStyleNone];
    }
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
