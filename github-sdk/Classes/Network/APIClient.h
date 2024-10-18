//
//  APIClient.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

@property (nonatomic, strong, readonly) NSURLSession *session;

- (instancetype)initWithSession:(NSURLSession *)session;
- (void)GET:(NSString *)urlString completion:(void (^)(NSDictionary *response, NSError *error))completion;

@end
