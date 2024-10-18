//
//  GitHubClient.h
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"
#import "Repo.h"
#import "Tag.h"

@interface GitHubClient : NSObject

@property (nonatomic, strong, readonly) APIClient *apiClient;

- (instancetype)initWithAPIClient:(APIClient *)apiClient;
- (void)fetchRepos:(NSString*)user completion:(void (^)(NSArray<Repo *> *repos, NSError *error))completion;
- (void)fetchTags:(NSString*)user andRepo:(NSString*)repo completion:(void (^)(NSArray<Tag *> *tags, NSError *error))completion;

@end
