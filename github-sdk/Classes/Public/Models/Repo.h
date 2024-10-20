//
//  Repo.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
