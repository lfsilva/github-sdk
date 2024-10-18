//
//  CacheService.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>

@interface CacheService : NSObject

- (void)saveDataToCache:(NSData *)data forURL:(NSString *)urlString;
- (NSData *)loadDataFromCache:(NSString *)urlString;

@end
