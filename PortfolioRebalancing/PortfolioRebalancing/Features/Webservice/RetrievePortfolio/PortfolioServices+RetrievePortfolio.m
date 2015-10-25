//
//  PortfolioServices+RetrievePortfolio.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioServices+RetrievePortfolio.h"
#import "PortfolioUtility.h"

@implementation PortfolioServices (RetrievePortfolio)

/**
 * retrieves the prices for a set of tickers defined in portfolio
 */
+ (NSDictionary*)getPortfolio:(NSString*)portfolioName username:(NSString*)username {
    
    //TODO: replace with real Web service
    return [PortfolioUtility getResponseFromJSONFileName:portfolioName];
}

@end
