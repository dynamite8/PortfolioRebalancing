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
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.listOfTickers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype)initWithListOfTickers:(NSDictionary *)inputList {
    
    self = [self init];
    
    [self parseListOfTickers:inputList];
    
    return self;
}

- (void)parseListOfTickers:(NSDictionary*)inputList {
    
    for (NSString* key in inputList.allKeys) {
        NSDictionary *dictionary = (NSDictionary*)[inputList objectForKey:key];
        
        NSLog(@"%@ = %@", key, dictionary);
        
        Ticker *ticker = [[Ticker alloc] init];
        ticker.tickerSymbol = (NSString*)key;
        ticker.sharesOwned = [(NSNumber*)[dictionary objectForKey:keySharesOwned] intValue];
        ticker.percentTargetAllocation = [(NSNumber*)[dictionary objectForKey:keyPercentTargetAllocation] floatValue];
        ticker.sharePrice = [self getTickerSharePrice:ticker.tickerSymbol];
        
        [self.listOfTickers addObject:ticker];
    }
}

- (void)parseListOfTickersFromFile:(NSString*)filename {
    
    NSDictionary *dictionary = [PortfolioUtility getResponseFromJSONFileName:filename];
    [self parseListOfTickers:dictionary];
}

- (NSString*)getRebalancedAllocation {
    
    [self calculateActualAllocation];
    
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


- (void)calculateActualAllocation {
    
    float sumTotal = 0;
    
    for (Ticker* ticker in self.listOfTickers) {
        sumTotal += ticker.calculateOwnedAmount;
    }
    
    for (Ticker* ticker in self.listOfTickers) {
        ticker.actualAllocation =  (ticker.calculateOwnedAmount/sumTotal)*100;
        ticker.desiredTargetAmount = sumTotal * ticker.percentTargetAllocation/100;
    }
}

- (float)getTickerSharePrice:(NSString*)ticker {
    
    if (self.listOfCurrentTickerPrice == nil) {
        self.listOfCurrentTickerPrice = [PortfolioUtility getResponseFromJSONFileName:@"CurrentPricesForTickers"];
    }
    
    return [(NSNumber*)[self.listOfCurrentTickerPrice valueForKey:ticker] floatValue];
}

@end
