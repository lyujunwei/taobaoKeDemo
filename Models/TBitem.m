//
//  TBitem.m
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "TBitem.h"
@implementation TBitem
@synthesize title ;
@synthesize fast_post_fee,seller_loc,is_cod,is_promotion,shipping,item_id,sold,location,nick,pic_path,price,price_with_rate,spu_id,url,user_id,hight;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fast_post_fee forKey:@"fast_post_fee"];
    [aCoder encodeObject:self.seller_loc forKey:@"seller_loc"];
    [aCoder encodeObject:self.is_cod forKey:@"is_cod"];
    [aCoder encodeObject:self.is_promotion forKey:@"is_promotion"];
    [aCoder encodeObject:self.shipping forKey:@"shipping"];
    [aCoder encodeObject:self.item_id forKey:@"item_id"];
    [aCoder encodeObject:self.sold forKey:@"sold"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.nick forKey:@"nick"];
    [aCoder encodeObject:self.pic_path forKey:@"pic_path"];
    [aCoder encodeObject:self.price_with_rate forKey:@"price_with_rate"];
    [aCoder encodeObject:self.spu_id forKey:@"spu_id"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
}
//fast_post_fee,seller_loc,is_cod,is_promotion,shipping,item_id,sold,location,nick,pic_path,price,price_with_rate,spu_id,url,user_id
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.title =  [aDecoder decodeObjectForKey:@"title"];
        self.fast_post_fee =  [aDecoder decodeObjectForKey:@"fast_post_fee"];
        self.seller_loc =  [aDecoder decodeObjectForKey:@"seller_loc"];
        self.is_cod =  [aDecoder decodeObjectForKey:@"is_cod"];
        self.is_promotion =  [aDecoder decodeObjectForKey:@"is_promotion"];
        self.shipping =  [aDecoder decodeObjectForKey:@"shipping"];
        self.item_id =  [aDecoder decodeObjectForKey:@"item_id"];
        self.sold =  [aDecoder decodeObjectForKey:@"sold"];
        self.location =  [aDecoder decodeObjectForKey:@"location"];
        self.nick =  [aDecoder decodeObjectForKey:@"nick"];
        self.pic_path =  [aDecoder decodeObjectForKey:@"pic_path"];
        self.price =  [aDecoder decodeObjectForKey:@"price"];
        self.price_with_rate =  [aDecoder decodeObjectForKey:@"price_with_rate"];
        self.spu_id =  [aDecoder decodeObjectForKey:@"spu_id"];
        self.url =  [aDecoder decodeObjectForKey:@"url"];
        self.user_id =  [aDecoder decodeObjectForKey:@"user_id"];
    }
    return self;
}
@end