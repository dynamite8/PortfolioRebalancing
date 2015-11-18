//
//  PortfolioManager.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioManager.h"

#import "TargetAllocationStrategy.h"
#import "PortfolioServices+RetrieveTickerPrices.h"
#import "Ticker+TargetAllocation.h"

@implementation PortfolioManager

+ (instancetype)initWithUsername:(NSString*)username {
    
    PortfolioManager *portfolioManager = [PortfolioManager sharedInstance];
    portfolioManager.username = username;
    return portfolioManager;
}

+ (instancetype)sharedInstance {
    
    static PortfolioManager *_sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [PortfolioManager new];
    });
    
    return _sharedInstance;
}

- (void)setupPorfolio:(NSString*)portfolioName {

    self.portfolio = [[Portfolio alloc] initWithPorfolioName:portfolioName];
}

/**
 * The current price of the shares can vary, so we have extracted this as a separate
 * call to retrieve the price from a file. In the future, the plan is to retrieve this
 * from a Web service.
 */
- (void)updatePortfolioTickerSharePrice {
    
    for (Ticker* ticker in self.portfolio.listOfTickers) {
        ticker.sharePrice = [PortfolioServices getTickerSharePrice:ticker.tickerSymbol];
    }
}

- (NSString*)getRebalanceTransactions {
    
    [self updatePortfolioTickerSharePrice];
    
    TargetAllocationStrategy *strategy = [[TargetAllocationStrategy alloc] initWithPortfolio:self.portfolio];
    return [strategy getRebalancedAllocation];
}

@end
