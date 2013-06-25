//
//  AppGCDManage.m
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "AppGCDManage.h"
@implementation AppGCDManage

+(void)ManageMainThread:(dispatch_block_t)block
{
    dispatch_async(dispatch_get_main_queue(), block);
}
+(void)ManageBackThread:(dispatch_block_t)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

@end
