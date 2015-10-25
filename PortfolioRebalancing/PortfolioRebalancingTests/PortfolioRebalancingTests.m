//
//  PortfolioRebalancingTests.m
//  PortfolioRebalancingTests
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PortfolioRebalancing/PortfolioManager.h>

@interface PortfolioRebalancingTests : XCTestCase

@end

@implementation PortfolioRebalancingTests

- (void)testParsingPortfolioFromFile {

    PortfolioManager *manager = [PortfolioManager sharedInstance];
    [manager setupPorfolio:@"SamplePortfolio"];
    NSString *expected = @"buy 9 of GOOG, sell 114 of TSLA";
    NSString *result = [manager getRebalanceTransactions];
    XCTAssertTrue([result isEqualToString:expected],
                   @"Strings are not equal %@", expected);
}

@end
