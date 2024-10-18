//
//  GitHubClientTests.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "GitHubClientTests.h"
#import "MockAPIClient.h"
#import "GitHubClient.h"

@implementation GitHubClientTests {
    MockAPIClient *mockClient;
    GitHubClient *sut;
}

- (void)setUp {
    [super setUp];
    
    mockClient = [[MockAPIClient alloc] init];
    sut = [[GitHubClient alloc] initWithAPIClient:mockClient];
}

- (void)tearDown {
    mockClient = nil;
    sut = nil;
    
    [super tearDown];
}

- (void)testGETRepoRequestSuccess {
    NSDictionary *mockResponse = @{
        @"name": @"quicktype",
        @"description": @"Generate types and converters from JSON, Schema, and GraphQL",
        @"private": @0
    };
    NSData *mockData = [NSJSONSerialization dataWithJSONObject:[NSArray arrayWithObject:mockResponse] options:0 error:nil];
    mockClient.mockData = mockData;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Repo Request Success"];
    
    [sut fetchRepos:@"lfsilva" completion:^(NSArray<Repo *> *repos, NSError *error) {
        XCTAssertNil(error, "Erro deve ser nulo");
        
        Repo *repo = repos.firstObject;
        XCTAssertEqualObjects(repo.name, @"quicktype", "Nome do repositório deve ser quicktype");
        XCTAssertEqualObjects(repo.detail, @"Generate types and converters from JSON, Schema, and GraphQL", "Descrição do repositório deve ser válida");
        XCTAssertEqual(repo.private, NO, "Deve ser um repositório privado");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGETRepoRequestFailure {
    NSError *mockError = [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:nil];
    mockClient.mockError = mockError;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Repo Request Failure"];
    
    [sut fetchRepos:@"lfsilva" completion:^(NSArray<Repo *> *repos, NSError *error) {
        XCTAssertNotNil(error, "Erro não deve ser nulo");
        XCTAssertEqual(error.code, 500, "Código de erro deve ser 500");
        XCTAssertEqual(repos.count, 0, "Resposta deve ser vazia.");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGETTagRequestSuccess {
    NSDictionary *mockResponse = @{@"name": @"v1.0.0"};
    NSData *mockData = [NSJSONSerialization dataWithJSONObject:[NSArray arrayWithObject:mockResponse] options:0 error:nil];
    mockClient.mockData = mockData;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Tag Request Success"];
    
    [sut fetchTags:@"lfsilva" andRepo:@"quicktype" completion:^(NSArray<Tag *> *tags, NSError *error) {
        XCTAssertNil(error, "Erro deve ser nulo");
        
        Tag *tag = tags.firstObject;
        XCTAssertEqualObjects(tag.name, @"v1.0.0", "Tag deve ser v1.0.0");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGETTagRequestFailure {
    NSError *mockError = [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:nil];
    mockClient.mockError = mockError;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Tag Request Failure"];
    
    [sut fetchTags:@"lfsilva" andRepo:@"quicktype" completion:^(NSArray<Tag *> *tags, NSError *error) {
        XCTAssertNotNil(error, "Erro não deve ser nulo");
        XCTAssertEqual(error.code, 500, "Código de erro deve ser 500");
        XCTAssertEqual(tags.count, 0, "Resposta deve ser vazia.");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
