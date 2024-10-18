//
//  GitHubSDK.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>
#import "Repo.h"
#import "Tag.h"

@interface GitHubSDK : NSObject

- (void)reposOf:(NSString*)user completion:(void (^)(NSArray<Repo *> *repos, NSError *error))completion;
- (void)tagsOf:(NSString*)repo belongsTo:(NSString*)user completion:(void (^)(NSArray<Tag *> *tags, NSError *error))completion;

@end
