//
//  Tag.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "Tag.h"

@implementation Tag

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
    }
    return self;
}

@end
