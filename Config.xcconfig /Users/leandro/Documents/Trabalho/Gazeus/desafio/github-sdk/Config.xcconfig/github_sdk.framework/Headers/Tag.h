//
//  Tag.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>

@interface Tag : NSObject

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
