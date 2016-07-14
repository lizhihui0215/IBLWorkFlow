//
//  IBLWorkFlowTests.m
//  IBLWorkFlowTests
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IBLWSDLServices.h"
#import "IBLRepository.h"
#import "IBLOrderRepository.h"

@interface IBLWorkFlowTests : XCTestCase

@end

@implementation IBLWorkFlowTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    IBLWSDLServices *services = [[IBLWSDLServices alloc] initWithFilename:@"Operator"];
    
    NSString *xml = [services buildSOAPWithMethodName:@"auth" parameters:@{@"arg0" : @"xxxxxxxxx"}];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *test = [IBLWSDLServices SOAPResultWithMethodName:@"authResponse" data:stringData];
    
    IBLRepository *ib = [[IBLRepository alloc] init];
//    NSString *signa = [ib siginWithParameters:@{@"appid" : @"asddasdasd",
//                              @"mch_id" : @"asddsad",
//                              @"aaa" : @"asddas",
//                              @"qqq" : @"asddasd",
//                              @"fff" : @"asddasda",} key:@"asddsad"];
    
//    NSLog(@"signa %@",signa);
    
    IBLOrderRepository *o = [[IBLOrderRepository alloc] init];
    
    IBLFetchMineOrderList *fetch = [IBLFetchMineOrderList listWithDateRange:@""
                                                                     status:@""
                                                                    account:@""
                                                                   username:@""
                                                                      phone:@""
                                                                       type:@""
                                                                    bizType:@""];
    
    [o fetchMineOrderListWithIsRefresh:YES
                                 fetch:fetch];
    
    
    NSLog(@"xml %@",xml);
    
    NSLog(@"test %@",test);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
