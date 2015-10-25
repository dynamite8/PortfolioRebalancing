//
//  Ticker.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "Ticker.h"

@implementation Ticker

- (instancetype)initTicker:(NSString*)ticker sharesOwned:(NSUInteger)sharesOwned percentTargetAllocation:(float)targetAllocation {
    
    self = [super init];
    
    if (self) {
        self.tickerSymbol = ticker;
        self.sharesOwned = sharesOwned;
        self.percentTargetAllocation = targetAllocation;
    }
    
    return self;
}

- (float)calculateOwnedAmount {
    
    return self.sharesOwned * self.sharePrice;
}

@end
