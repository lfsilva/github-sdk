//
//  MockAPIClient.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"

@interface MockAPIClient : APIClient

@property (nonatomic, strong) NSData *mockData;
@property (nonatomic, strong) NSError *mockError;

@end
