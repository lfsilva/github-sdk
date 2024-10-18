//
//  GitHubSDK.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "GitHubSDK.h"
#import "GitHubClient.h"

@interface GitHubSDK()

@property (nonatomic, strong, readonly) GitHubClient *client;

@end

@implementation GitHubSDK

- (instancetype)init {
    self = [super init];
    if (self) {
        _client = [[GitHubClient alloc] init];
    }
    return self;
}

- (NSString*) projectName {
    return @"GitHub SDK";
}

- (void)reposOf:(NSString*)user completion:(void (^)(NSArray<Repo *> *repos, NSError *error))completion {
    [self.client fetchRepos:user completion:completion];
}

- (void)tagsOf:(NSString*)repo belongsTo:(NSString*)user completion:(void (^)(NSArray<Tag *> *tags, NSError *error))completion {
    [self.client fetchTags:user andRepo:repo completion:completion];
}

@end
