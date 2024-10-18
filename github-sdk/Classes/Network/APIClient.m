//
//  APIClient.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Reachability/Reachability.h>
#import "APIClient.h"
#import "CacheService.h"

@interface APIClient()

@property (nonatomic, strong) CacheService *cacheService;

@end

@implementation APIClient


- (instancetype)init {
    return [self initWithSession:[NSURLSession sharedSession]];
}

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
        _cacheService = [[CacheService alloc] init];
    }
    return self;
}

- (void)GET:(NSString *)urlString withHeaders:(NSDictionary<NSString *, NSString *> *)headers completion:(void (^)(NSDictionary *response, NSError *error))completion {
    
    if (![self isConnected]) {
        NSData *cachedData = [self.cacheService loadDataFromCache:urlString];
        if (cachedData) {
            NSError *jsonError;
            NSDictionary *cachedResponse = [NSJSONSerialization JSONObjectWithData:cachedData options:0 error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                completion(cachedResponse, nil);
            }
        } else {
            NSError *cacheError = [NSError errorWithDomain:@"APIClientErrorDomain"
                                                      code:101
                                                  userInfo:@{NSLocalizedDescriptionKey: @"No cached data available and no internet connection."}];
            completion(nil, cacheError);
        }
        return;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSURL *url = components.URL;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    for (NSString *key in headers) {
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (json == nil || json.count == 0) {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:nil];
            completion(nil, error);
            return;
        }
        
        if ([json isKindOfClass:[NSArray class]]) {
            completion(json, jsonError);
            [self.cacheService saveDataToCache:data forURL:urlString];
            return;
        }
        
        NSString *status = json[@"status"];
        NSString *message = json[@"message"];
        if (status != nil && message != nil) {
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:message forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:[status intValue] userInfo:details];
            completion(nil, error);
            return;
        }
    }];
    
    [dataTask resume];
}

- (BOOL)isConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
