//
//  NSMutableDictionary+tmallSeach.h
//  TB
//
//  Created by kimilee on 13-6-8.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSMutableDictionary (tmallSeach)
//调用的APi名字
-(void)setMethod:(NSString * )method;
//
-(void)setPage_size:(NSString * )page_size;
//表示搜索的关键字，例如搜索query=nike。当输入关键字为中文时，将对他进行URLEncode的UTF-8格式编码，如 耐克，那么q=%E8%80%90%E5%85%8B。
-(void)setSeachName:(NSString *)q;

//排序类型。类型包括： s: 人气排序 p: 价格从低到高; pd: 价格从高到低; d: 月销量从高到低; td: 总销量从高到低; pt: 按发布时间排序.
-(void)setSortBy:(NSString * )sort;

//可以用该字段来实现分页功能。表示查询起始位置，默认从第0条开始，start=10,表示从第10条数据开始查询，start不得大于1000。
-(void)setStart:(NSString * )start;

//品牌的id。点击某品牌类目的时候会出现。
-(void)setBrand:(NSString * )setBrand;

//商品最低价格
-(void)setStart_price:(NSString * )start_price;

//是否包邮，-1为包邮
-(void)setPost_fee:(NSString * )Post_fee;

//商品最高价格
-(void)setEnd_price:(NSString * )end_price;

//商品标签。品牌特卖商品库：3458；天猫原创商品库：4801,不再支持 天猫精品库：8578；
-(void)setAuction_tag:(NSString * )auction_tag;

//前台类目id，目前其他接口无法获取，只能自己去寻找。建议使用关键字获取数据。支持多选过滤，cat=catid1,catid2。
-(void)setCat:(NSString * )cat;

@end
