//
//  APIClient.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "APIClient.h"

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

- (void)GET:(NSString *)urlString completion:(void (^)(NSDictionary *response, NSError *error))completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSURL *url = components.URL;
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        completion(json, jsonError);
    }];
    
    [dataTask resume];
}

@end
