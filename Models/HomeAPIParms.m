//
//  HomeAPIParms.m
//  TB
//
//  Created by kimilee on 13-6-8.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "HomeAPIParms.h"
@implementation HomeAPIParms
-(id)initWithBaseParamsMethod:(NSString *)method
                    SeachName:(NSString *)q
                         start:(NSString*)start
{
    self = (HomeAPIParms*)[[NSMutableDictionary alloc]init];
    if (self) {
        [self setMethod:method];
        [self setSeachName:q];
        [self setStart:start];
    }
    return self;
}
-(id)initWithBaseParamsMethodBySort:(NSString *)method
                    SeachName:(NSString *)q
                               page:(NSString*)page
                               Sort:(NSString*)sort
{
    self = [self initWithBaseParamsMethod:method SeachName:q start:page];
    if (self) {
        [self setSortBy:sort];
    }
    return self;
}
-(id)initWithBaseParamsMethodBySortByPageSize:(NSString *)method
                          SeachName:(NSString *)q
                               page:(NSString*)page
                               Sort:(NSString*)sort
                                     PageSize:(NSString*)pageSize
{
    self = [self initWithBaseParamsMethodBySort:method SeachName:q page:page Sort:sort];
    if (self) {
        [self setPage_size:pageSize];
    }
    return self;
}

@end
