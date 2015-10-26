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
    NSString *expected = @"sell 114 of TSLA, buy 9 of GOOG";
    NSString *expected2 = @"buy 9 of GOOG, sell 114 of TSLA";
    NSString *result = [portfolio getRebalancedAllocation];
    XCTAssertTrue([result isEqualToString:expected] || [result isEqualToString:expected2],
                   @"Strings are not equal %@", expected);
}

@end
