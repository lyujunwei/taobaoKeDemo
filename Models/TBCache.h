//
//  TBCache.h
//  TB
//
//  Created by kimilee on 13-6-7.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCache : NSObject
+ (void) resetCache;
+ (void) setObject:(id)data forKey:(NSString*)key;
+ (id) getObjectForKey:(NSString*)key;
@end
