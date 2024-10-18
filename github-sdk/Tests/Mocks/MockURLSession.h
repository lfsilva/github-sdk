//
//  MockURLSession.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

@import Foundation;

@interface MockURLSession : NSURLSession

@property (nonatomic, strong) NSData *mockData;
@property (nonatomic, strong) NSError *mockError;

@end
