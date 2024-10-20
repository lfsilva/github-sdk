//
//  CacheService.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "CacheService.h"

@implementation CacheService

- (void)saveDataToCache:(NSData *)data forURL:(NSString *)urlString {
    NSString *cachePath = [self cachePathForURL:urlString];
    [data writeToFile:cachePath atomically:YES];
}

- (NSData *)loadDataFromCache:(NSString *)urlString {
    NSString *cachePath = [self cachePathForURL:urlString];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        return [NSData dataWithContentsOfFile:cachePath];
    }
    return nil;
}

- (NSString *)cachePathForURL:(NSString *)urlString {
    NSString *encodedKey = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = [[encodedKey stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]] stringByAppendingString:@".cache"];
    return [cacheDir stringByAppendingPathComponent:fileName];
}

- (NSString *)encodedKey:(NSString *)key {
    return [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}

@end
