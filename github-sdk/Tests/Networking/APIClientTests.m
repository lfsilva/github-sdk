//
//  APIClientTests.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "APIClientTests.h"
#import "MockURLSession.h"

@implementation APIClientTests {
    APIClient *client;
    MockURLSession *mockSession;
}

- (void)setUp {
    [super setUp];
    
    mockSession = [[MockURLSession alloc] init];
    client = [[APIClient alloc] initWithSession:mockSession];
}

- (void)tearDown {
    client = nil;
    mockSession = nil;
    
    [super tearDown];
}

- (void)testGETRequestSuccess {
    NSDictionary *mockResponse = @{@"name": @"John", @"email": @"john@example.com", @"age": @30};
    NSData *mockData = [NSJSONSerialization dataWithJSONObject:mockResponse options:0 error:nil];
    mockSession.mockData = mockData;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Request Success"];
    
    [client GET:@"https://api.example.com/user" completion:^(id response, NSError *error) {
        XCTAssertNil(error, "Erro deve ser nulo");
        
        NSDictionary *responseDict = (NSDictionary *)response;
        XCTAssertEqualObjects(responseDict[@"name"], @"John", "Nome deve ser John");
        XCTAssertEqualObjects(responseDict[@"email"], @"john@example.com", "Email deve ser john@example.com");
        XCTAssertEqual([responseDict[@"age"] integerValue], 30, "Idade deve ser 30");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGETRequestFailure {
    NSError *mockError = [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:nil];
    mockSession.mockError = mockError;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Request Failure"];
    
    [client GET:@"https://api.example.com/user" completion:^(id response, NSError *error) {
        XCTAssertNotNil(error, "Erro não deve ser nulo");
        XCTAssertEqual(error.code, 500, "Código de erro deve ser 500");
        XCTAssertNil(response, "Resposta deve ser nula em caso de erro");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
