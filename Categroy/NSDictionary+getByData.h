//
//  NSDictionary+getByData.h
//  TB
//
//  Created by kimilee on 13-6-7.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (getByData)
+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data;
@end
