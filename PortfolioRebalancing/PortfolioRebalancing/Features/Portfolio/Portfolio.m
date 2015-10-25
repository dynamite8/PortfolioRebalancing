//
//  Portfolio.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <PortfolioRebalancing/Portfolio.h>
#import "Ticker.h"
#import "PortfolioUtility.h"
#import "PortfolioServices+RetrievePortfolio.h"

//@interface Portfolio()
//@end

@implementation Portfolio

static const NSString *keySharesOwned = @"sharesOwned";
static const NSString *keyPercentTargetAllocation = @"targetAllocation";

//designated initializer
- (instancetype)initWithPorfolioName:(NSString*)portfolioName {
    
    self = [super init];
    
    if (self) {
        self.listOfTickers = [[NSMutableArray alloc] init];
        [self parseListOfTickers:[PortfolioServices getPortfolio:portfolioName username:@""]];
    }
    
    return self;
}

/**
 * Reusable method to parse the list of tickers for a portfolio
 */
- (void)parseListOfTickers:(NSDictionary*)inputList {
    
    for (NSString* key in inputList.allKeys) {
        NSDictionary *dictionary = (NSDictionary*)[inputList objectForKey:key];
        
        NSLog(@"%@ = %@", key, dictionary);
        
        int sharesOwned = [(NSNumber*)[dictionary objectForKey:keySharesOwned] intValue];
        int percentTargetAllocation = [(NSNumber*)[dictionary objectForKey:keyPercentTargetAllocation] floatValue];
        
        Ticker *ticker = [[Ticker alloc] initTicker:key sharesOwned:sharesOwned percentTargetAllocation:percentTargetAllocation];
        
        [self.listOfTickers addObject:ticker];
    }
}

@end
