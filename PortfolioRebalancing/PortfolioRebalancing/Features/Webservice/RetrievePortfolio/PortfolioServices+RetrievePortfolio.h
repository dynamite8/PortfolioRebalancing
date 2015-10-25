//
//  PortfolioServices+RetrievePortfolio.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioServices.h"

@interface PortfolioServices (RetrievePortfolio)

+ (NSDictionary*)getPortfolio:(NSString*)portfolioName username:(NSString*)username;

@end
