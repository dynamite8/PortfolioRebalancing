//
//  PortfolioServices+RetrieveTickerPrices.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioServices.h"

@interface PortfolioServices (RetrieveTickerPrices)

+ (NSDictionary*)getTickerSharePrices:(NSArray*)listOfTickers;
+ (float)getTickerSharePrice:(NSString*)ticker;

@end
