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

- (void)testParsingPortfolioFromFile {
    
    Portfolio *portfolio = [[Portfolio alloc] initWithListOfTickersFile:@"SamplePortfolio"];
    NSString *expected = @"buy 9 of GOOG, sell 114 of TSLA";
    NSString *result = [portfolio getRebalancedAllocation];
    XCTAssertTrue([result isEqualToString:expected],
                   @"Strings are not equal %@", expected);
}

- (void)testFinancialsRebalancing {
    
    Portfolio *portfolio = [[Portfolio alloc] initWithListOfTickersFile:@"FinancialPortfolio"];
    NSString *expected = @"sell 101 of CM, buy 243 of RY, sell 155 of BMO, buy 28 of TD";
    NSString *result = [portfolio getRebalancedAllocation];
    XCTAssertTrue([result isEqualToString:expected],
                  @"Strings are not equal %@", expected);
}

@end
