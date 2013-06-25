//
//  NSMutableDictionary+tmallSeach.m
//  TB
//
//  Created by kimilee on 13-6-8.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//

#import "NSMutableDictionary+tmallSeach.h"

@implementation NSMutableDictionary (tmallSeach)
-(void)setMethod:(NSString * )method
{
    [self setValue:method forKey:@"method"];
}
-(void)setPage_size:(NSString * )page_size
{
    [self setValue:page_size forKey:@"page_size"];
}
-(void)setSeachName:(NSString *)q
{
    [self setValue:q forKey:@"q"];
}
-(void)setSortBy:(NSString * )sort
{
    [self setValue:sort forKey:@"sort"];
}
-(void)setStart:(NSString * )start
{
    [self setValue:start forKey:@"start"];
}
-(void)setBrand:(NSString * )setBrand
{
    [self setValue:setBrand forKey:@"brand"];
}
-(void)setStart_price:(NSString * )start_price
{
    [self setValue:start_price forKey:@"start_price"];
}
-(void)setPost_fee:(NSString * )Post_fee
{
    [self setValue:Post_fee forKey:@"post_fee"];
}
-(void)setEnd_price:(NSString * )end_price
{
    [self setValue:end_price forKey:@"end_price"];
}
-(void)setAuction_tag:(NSString * )auction_tag
{
    [self setValue:auction_tag forKey:@"auction_tag"];
}
-(void)setCat:(NSString * )cat
{
    [self setValue:cat forKey:@"cat"];
}

@end
