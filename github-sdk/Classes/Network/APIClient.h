//
//  APIClient.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

@import Foundation;

@interface APIClient : NSObject

- (void)GET:(NSString *)urlString completion:(void (^)(NSDictionary *response, NSError *error))completion;

@end
