//
//  TBCache.m
//  TB
//
//  Created by kimilee on 13-6-7.
//  Copyright (c) 2013年 kimilee. All rights reserved.
//
#import "TBCache.h"
@implementation TBCache
static NSTimeInterval cacheTime =  (double)600000;
//重置缓存
+ (void) resetCache {
	[[NSFileManager defaultManager] removeItemAtPath:[TBCache cacheDirectory] error:nil];
}

+ (NSString*) cacheDirectory {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheDirectory = [paths objectAtIndex:0];
	cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"TBCache"];
	return cacheDirectory;
}

+(id)getObjectForKey:(NSString*)key {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
	
	if ([fileManager fileExistsAtPath:filename])
	{
		NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
		if ([modificationDate timeIntervalSinceNow] > cacheTime) {
			//[fileManager removeItemAtPath:filename error:nil];
		} else {
			NSData *data = [NSData dataWithContentsOfFile:filename];
            data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
			return data;
		}
	}
	return nil;
}
+ (void) setObject:(id)data forKey:(NSString*)key {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *filename = [self.cacheDirectory stringByAppendingPathComponent:key];
	BOOL isDir = YES;
	if (![fileManager fileExistsAtPath:self.cacheDirectory isDirectory:&isDir]) {
		[fileManager createDirectoryAtPath:self.cacheDirectory withIntermediateDirectories:NO attributes:nil error:nil];
	}
	NSError *error;
	@try {
        data = [NSKeyedArchiver archivedDataWithRootObject:data];
		[data writeToFile:filename options:NSDataWritingAtomic error:&error];
	}
	@catch (NSException * e)
    {
        DebugLog(@"Exception:%@",e);
	}
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
