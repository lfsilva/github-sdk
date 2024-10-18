//
//  GitHubSDK.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "GitHubSDK.h"
#import "GitHubService.h"

@interface GitHubSDK()

@property (nonatomic, strong, readonly) GitHubService *service;

@end

@implementation GitHubSDK

- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [[GitHubService alloc] init];
    }
    return self;
}

- (void)reposOf:(NSString*)user completion:(void (^)(NSArray<Repo *> *repos, NSError *error))completion {
    [self.service fetchRepos:user completion:completion];
}

- (void)tagsOf:(NSString*)repo belongsTo:(NSString*)user completion:(void (^)(NSArray<Tag *> *tags, NSError *error))completion {
    [self.service fetchTags:user andRepo:repo completion:completion];
}

@end
