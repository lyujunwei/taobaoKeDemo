//
//  TBitem.h
//  TB
//
//  Created by kimilee on 13-6-6.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface TBitem : BaseModel<NSCoding>
{
    NSMutableDictionary * allAttribute;
}
@property NSNumber * hight;
//邮费
@property(nonatomic,strong)NSString * fast_post_fee;

//是否货到付款
@property(nonatomic,strong)NSString * is_cod;

//是否折扣
@property(nonatomic,strong)NSString * is_promotion;

//搜索宝贝的数字id
@property(nonatomic,strong)NSString * item_id;

//搜索宝贝的宝贝所在地
@property(nonatomic,strong)NSString * location;

//搜索宝贝的卖家昵称
@property(nonatomic,strong)NSString * nick;

//搜索宝贝的图片url
@property(nonatomic,strong)NSString * pic_path;

///搜索宝贝的一口价
@property(nonatomic,strong)NSString * price;

//搜索宝贝的一口价折扣价
@property(nonatomic,strong)NSString * price_with_rate;

//搜索宝贝的卖家所在地
@property(nonatomic,strong)NSString * seller_loc;

//是否免邮
@property(nonatomic,strong)NSString * shipping;

//搜索宝贝的已售数量
@property(nonatomic,strong)NSString * sold;

//搜索宝贝的spuid
@property(nonatomic,strong)NSString * spu_id;

//搜索宝贝url
@property(nonatomic,strong)NSString * url;

//搜索宝贝的卖家数字id
@property(nonatomic,strong) NSString * user_id;

//搜索宝贝的标题
@property(nonatomic,strong) NSString * title;

//从JSON类转换成Model类

@end
