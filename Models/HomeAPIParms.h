//
//  HomeAPIParms.h
//  TB
//
//  Created by kimilee on 13-6-8.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HomeAPIParms : NSMutableDictionary

-(id)initWithBaseParamsMethod:(NSString *)method
                    SeachName:(NSString *)q
                        start:(NSString*)start;

-(id)initWithBaseParamsMethodBySort:(NSString *)method
                          SeachName:(NSString *)q
                               page:(NSString*)page
                               Sort:(NSString*)sort;

-(id)initWithBaseParamsMethodBySortByPageSize:(NSString *)method
                                    SeachName:(NSString *)q
                                         page:(NSString*)page
                                         Sort:(NSString*)sort
                                     PageSize:(NSString*)pageSize;
@end
