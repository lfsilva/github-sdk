//
//  GitHubClient.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "GitHubClient.h"

@implementation GitHubClient

- (instancetype)init {
    return [self initWithAPIClient:[[APIClient alloc] init]];
}

- (instancetype)initWithAPIClient:(APIClient *)apiClient {
    self = [super init];
    if (self) {
        _apiClient = apiClient;
    }
    return self;
}

- (void)fetchRepos:(NSString*)user completion:(void (^)(NSArray<Repo *> *repos, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", user];
    NSDictionary *headers = @{
        @"Accept": @"application/vnd.github+json",
        @"Authorization": @"Bearer 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",
        @"X-GitHub-Api-Version": @"2022-11-28"
    };
    [self.apiClient GET:url withHeaders:headers completion:^(NSDictionary *response, NSError *error) {
        NSMutableArray<Repo *> *repos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in response) {
            Repo *repo = [[Repo alloc] initWithDictionary:dic];
            [repos addObject:repo];
        }
        
        completion([repos copy], error);
    }];
}

- (void)fetchTags:(NSString*)user andRepo:(NSString*)repo completion:(void (^)(NSArray<Tag *> *tags, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/tags", user, repo];
    NSDictionary *headers = @{
        @"Accept": @"application/vnd.github+json",
        @"Authorization": @"Bearer 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",
        @"X-GitHub-Api-Version": @"2022-11-28"
    };
    [self.apiClient GET:url withHeaders:headers completion:^(NSDictionary *response, NSError *error) {
        NSMutableArray<Tag *> *tags = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in response) {
            Tag *tag = [[Tag alloc] initWithDictionary:dic];
            [tags addObject:tag];
        }
        
        completion([tags copy], error);
    }];
}

@end
