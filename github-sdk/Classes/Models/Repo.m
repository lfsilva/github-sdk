//
//  Repo.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _detail = dictionary[@"description"];
        _private = [dictionary[@"private"] boolValue];
    }
    return self;
}

@end
