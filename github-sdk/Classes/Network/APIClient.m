//
//  APIClient.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "APIClient.h"

@implementation APIClient

- (instancetype)init {
    return [self initWithSession:[NSURLSession sharedSession]];
}

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (void)GET:(NSString *)urlString completion:(void (^)(NSDictionary *response, NSError *error))completion {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSURL *url = components.URL;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
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
