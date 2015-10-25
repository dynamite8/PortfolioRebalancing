//
//  PortfolioServices+RetrieveTickerPrices.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioServices+RetrieveTickerPrices.h"
#import "PortfolioUtility.h"

@implementation PortfolioServices (RetrieveTickerPrices)

/**
 * retrieves the prices for a set of tickers defined in portfolio
 */
+ (NSDictionary*)getTickerSharePrices:(NSArray*)listOfTickers {
    
    //TODO: replace with real Web service
    NSDictionary *response = [PortfolioUtility getResponseFromJSONFileName:@"CurrentPricesForTickers"];
    NSMutableDictionary *prices = [[NSMutableDictionary alloc] init];
    for (NSString *key in listOfTickers) {
        if (response[key] != nil) {
            [prices setObject:response[key] forKey:key];
        }
    }
    
    return prices;
}

+ (float)getTickerSharePrice:(NSString*)ticker {
    
    NSDictionary *response = [PortfolioUtility getResponseFromJSONFileName:@"CurrentPricesForTickers"];
    return [(NSNumber*)[response valueForKey:ticker] floatValue];
}

@end
