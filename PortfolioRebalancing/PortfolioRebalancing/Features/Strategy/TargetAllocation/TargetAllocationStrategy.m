//
//  TargetAllocationStrategy.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "TargetAllocationStrategy.h"
//#import "PortfolioRebalanceStrategy.h"
#import "Ticker+TargetAllocation.h"

@interface TargetAllocationStrategy () <PortfolioRebalanceStrategyDelegate>

@end

@implementation TargetAllocationStrategy

- (instancetype)initWithPortfolio:(Portfolio *)portfolio {
    self = [super init];
    
    if (self) {
        _portfolio = portfolio;
//        [_portfolioTickers setArray:[[portfolio listOfTickers] copy]];
    }
    
    return self;
}

/**
 * Returns recommendations for the transactions to re-balance the portfolio
 */
- (NSString*)getRebalancedAllocation {
    
    [self calculateActualAndDesiredAllocation];
    
    NSMutableArray *transactions = [[NSMutableArray alloc] init];
    
    if (self.portfolio.listOfTickers != nil && self.portfolio.listOfTickers.count > 0) {
        for (Ticker *ticker in self.portfolio.listOfTickers) {
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
    
    for (Ticker* ticker in self.portfolio.listOfTickers) {
        sumTotal += ticker.calculateOwnedAmount;
    }
    
    for (Ticker* ticker in self.portfolio.listOfTickers) {
        ticker.actualAllocation =  (ticker.calculateOwnedAmount/sumTotal)*100;
        ticker.desiredTargetAmount = sumTotal * ticker.percentTargetAllocation/100;
    }
}


@end
