//
//  IBLWorkFlowTests.m
//  IBLWorkFlowTests
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IBLWSDLServices.h"

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
    
    IBLWSDLServices *services = [[IBLWSDLServices alloc] initWithFilename:@"User"];
    
    NSString *xml = [services buildSOAPWithMethodName:@"openAccount" parameters:@{@"arg0" : @"xxxxxxxxx"}];
    
    NSLog(@"xml %@",xml);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
