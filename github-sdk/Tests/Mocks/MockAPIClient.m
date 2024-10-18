//
//  MockAPIClient.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "MockAPIClient.h"

@implementation MockAPIClient

- (void)GET:(NSString *)urlString withHeaders:(NSDictionary<NSString *, NSString *> *)headers completion:(void (^)(NSDictionary *response, NSError *error))completion {
    if (self.mockData == nil) {
        completion(nil, self.mockError);
        return;
    }
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.mockData options:0 error:&jsonError];
    completion(json, self.mockError);
}

@end
