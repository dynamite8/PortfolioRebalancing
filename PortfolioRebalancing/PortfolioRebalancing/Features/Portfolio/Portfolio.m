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

@implementation Portfolio

static const NSString *keySharesOwned = @"sharesOwned";
static const NSString *keyPercentTargetAllocation = @"targetAllocation";

//designated initializer
- (instancetype)initWithListOfTickers:(NSDictionary *)inputList {
    
    self = [super init];
    
    if (self) {
        self.listOfTickers = [[NSMutableArray alloc] init];
        [self parseListOfTickers:inputList];
    }
    
    return self;
}

- (instancetype)initWithListOfTickersFile:(NSString *)filename {
    
    return [self initWithListOfTickers:[PortfolioUtility getResponseFromJSONFileName:filename]];
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

- (void)parseListOfTickersFromFile:(NSString*)filename {
    
    NSDictionary *dictionary = [PortfolioUtility getResponseFromJSONFileName:filename];
    [self parseListOfTickers:dictionary];
}

/**
 * Returns recommendations for the transactions to re-balance the portfolio
 */
- (NSString*)getRebalancedAllocation {
    
    [self calculateActualAndDesiredAllocation];
    
    NSMutableArray *transactions = [[NSMutableArray alloc] init];
    
    if (self.listOfTickers != nil && self.listOfTickers.count > 0) {
        for (Ticker *ticker in self.listOfTickers) {
            if (ticker.balanceNumberOfShares > 0) {
                [transactions addObject:[NSString stringWithFormat:@"buy %d of %@", ticker.balanceNumberOfShares, ticker.tickerSymbol]];
            } else if (ticker.balanceNumberOfShares < 0) {
                [transactions addObject:[NSString stringWithFormat:@"sell %d of %@", ticker.balanceNumberOfShares * -1, ticker.tickerSymbol]];
            }
        }
    }
    
    return [[transactions copy] componentsJoinedByString:@", "];
}

/**
 * This function calculates the actual allocation and the re-balanced amount for the portfolio
 */
- (void)calculateActualAndDesiredAllocation {
    
    float sumTotal = 0;
    
    for (Ticker* ticker in self.listOfTickers) {
        ticker.sharePrice = [self getTickerSharePrice:ticker.tickerSymbol];
        sumTotal += ticker.calculateOwnedAmount;
    }
    
    for (Ticker* ticker in self.listOfTickers) {
        ticker.actualAllocation =  (ticker.calculateOwnedAmount/sumTotal)*100;
        ticker.desiredTargetAmount = sumTotal * ticker.percentTargetAllocation/100;
    }
}

/**
 * The current price of the shares can vary, so we have extracted this as a separate
 * call to retrieve the price from a file. In the future, the plan is to retrieve this
 * from a Web service.
 */
- (float)getTickerSharePrice:(NSString*)ticker {
    
    //TODO: use a Web service
    if (self.listOfCurrentTickerPrice == nil) {
        self.listOfCurrentTickerPrice = [PortfolioUtility getResponseFromJSONFileName:@"CurrentPricesForTickers"];
    }
    
    return [(NSNumber*)[self.listOfCurrentTickerPrice valueForKey:ticker] floatValue];
}

@end
