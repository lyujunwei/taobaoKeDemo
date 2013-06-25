//
//  BaseModel.m
//  TB
//
//  Created by kimilee on 13-6-8.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "BaseModel.h"
@implementation BaseModel
+ (id)instancefromJsonDic:(NSDictionary*)dic
{
    id instance = nil;
    @try {
        instance = [[self alloc] init];
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            id item = [dic objectForKey:key];
            if ([item isMemberOfClass:[NSNull class]]) {
                continue;
            } else if ([item isKindOfClass:[NSDictionary class]]) {
                //add another LC instance
            } else if ([item isKindOfClass:[NSArray class]]) {
                //add a LC instances array
            } else {
                //NSLog(@"class name: %@", [item class]);
                [instance setValue:item forKey:key];
            }
        }
    }
    @catch (NSException *exception) {
        DebugLog(@"Drat! Something wrong: %@", exception.reason);
    }
	return instance;
}
@end
