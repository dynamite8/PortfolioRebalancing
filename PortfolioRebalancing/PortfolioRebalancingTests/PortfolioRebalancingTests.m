//
//  PortfolioRebalancingTests.m
//  PortfolioRebalancingTests
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PortfolioRebalancing/Portfolio.h>

@interface PortfolioRebalancingTests : XCTestCase

@end

@implementation PortfolioRebalancingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingPortfolioFromFile {
    
    Portfolio *portfolio = [[Portfolio alloc] init];
    [portfolio parseListOfTickersFromFile:@"SamplePortfolio"];
    NSString *expected = @"buy 9 of GOOG, sell 114 of TSLA";
    NSString *result = [portfolio getRebalancedAllocation];
    XCTAssertTrue([result isEqualToString:expected],
                   @"Strings are not equal %@", expected);
}

@end
