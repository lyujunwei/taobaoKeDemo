//
//  AppGCDManage.h
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppGCDManage : NSObject
+(void)ManageMainThread:(dispatch_block_t)block;
+(void)ManageBackThread:(dispatch_block_t)block;
@end
