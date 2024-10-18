//
//  MockURLSession.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "MockURLSession.h"

@interface MockURLSession()

@end

@implementation MockURLSession

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    completionHandler(self.mockData, nil, self.mockError);
    return nil;
}

@end
