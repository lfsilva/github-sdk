//
//  CacheServiceTests.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "CacheServiceTests.h"
#import "CacheService.h"

@implementation CacheServiceTests {
    CacheService *sut;
}

- (void)setUp {
    [super setUp];
    
    sut = [[CacheService alloc] init];
}

- (void)tearDown {
    sut = nil;
    [self clearCache];
    
    [super tearDown];
}

- (void)testSaveAndLoadData {
    NSString *testURL = @"https://example.com/api/test";
    NSData *testData = [@"Test data for cache" dataUsingEncoding:NSUTF8StringEncoding];

    [sut saveDataToCache:testData forURL:testURL];

    NSData *cachedData = [sut loadDataFromCache:testURL];

    XCTAssertNotNil(cachedData);
    XCTAssertEqualObjects(testData, cachedData, @"Os dados carregados do cache não correspondem aos dados originais.");
}

- (void)testLoadNonExistentCache {
    NSString *testURL = @"https://example.com/api/nonexistent";
    NSData *cachedData = [sut loadDataFromCache:testURL];
    XCTAssertNil(cachedData, @"Nenhum dado deve ser retornado para uma URL sem cache.");
}

- (void)clearCache {
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:cacheDir error:nil];
    
    for (NSString *filePath in cacheFiles) {
        NSString *fullPath = [cacheDir stringByAppendingPathComponent:filePath];
        [fileManager removeItemAtPath:fullPath error:nil];
    }
}

@end
