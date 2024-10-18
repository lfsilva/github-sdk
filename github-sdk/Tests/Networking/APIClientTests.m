//
//  APIClientTests.m
//  Pods
//
//  Created by Leandro Silva on 17/10/24.
//

#import "APIClientTests.h"
#import "APIClient.h"
#import "MockURLSession.h"

@implementation APIClientTests {
    MockURLSession *mockSession;
    APIClient *sut;
}

- (void)setUp {
    [super setUp];
    
    mockSession = [[MockURLSession alloc] init];
    sut = [[APIClient alloc] initWithSession:mockSession];
}

- (void)tearDown {
    mockSession = nil;
    sut = nil;
    
    [super tearDown];
}

- (void)testGETRequestSuccess {
    NSDictionary *mockResponse = @{@"name": @"John", @"email": @"john@example.com", @"age": @30};
    NSData *mockData = [NSJSONSerialization dataWithJSONObject:mockResponse options:0 error:nil];
    mockSession.mockData = mockData;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Request Success"];
    
    [sut GET:@"https://api.example.com/user" withHeaders:nil completion:^(id response, NSError *error) {
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
    
    [sut GET:@"https://api.example.com/user" withHeaders:nil completion:^(id response, NSError *error) {
        XCTAssertNotNil(error, "Erro não deve ser nulo");
        XCTAssertEqual(error.code, 500, "Código de erro deve ser 500");
        XCTAssertNil(response, "Resposta deve ser nula em caso de erro");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
