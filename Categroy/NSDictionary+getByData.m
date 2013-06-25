//
//  NSDictionary+getByData.m
//  TB
//
//  Created by kimilee on 13-6-7.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "NSDictionary+getByData.h"

@implementation NSDictionary (getByData)
+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data {
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data,
                                                               kCFPropertyListImmutable,
                                                               NULL);
    if(plist == nil) return nil;
    if ([(__bridge id)plist isKindOfClass:[NSDictionary class]]) {
        return (__bridge NSDictionary *)plist;
    }
    else {
        CFRelease(plist);
        return nil;
    }
}
@end
