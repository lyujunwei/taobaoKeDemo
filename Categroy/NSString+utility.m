//
//  NSString+utility.m
//  TB
//
//  Created by kimilee on 13-6-9.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import <time.h>
#import "NSString+utility.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (utility)
- (NSString *) MD5Hash {
	
	CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
	CC_MD5_Update (&md5, [self UTF8String], [self length]);
	
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
	NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
	return s;
}
- (NSString *)URLEncodedString
{
    //[self stringByAddingPercentEscapesUsingEncoding:nil];
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&amp;=+$,/?%#[] "),
                                            kCFStringEncodingUTF8));
    return result;
}

+(NSString *)getURLcodeString:(NSString *)string
{
    string = [string URLEncodedString];
    return string;
}
- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    return result;
}
+(NSString *)getLImageUrl:(NSString *)string
{
    //http://img03.taobaocdn.com/bao/uploaded/i3/18560021486860707/T1pEX9XxRXXXXXXXXX_!!0-item_pic.jpg_160x160.jpg
    string= [string  stringByReplacingOccurrencesOfString:@"160x160" withString:@"480x480"];
    return string;
}
+(NSString *)getSImageUrl:(NSString *)string
{
    //http://img03.taobaocdn.com/bao/uploaded/i3/18560021486860707/T1pEX9XxRXXXXXXXXX_!!0-item_pic.jpg_160x160.jpg
    string= [string  stringByReplacingOccurrencesOfString:@"160x160" withString:@"300x300"];
    return string;
}
@end