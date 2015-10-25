//
//  Ticker+TargetAllocation.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "Ticker+TargetAllocation.h"

@implementation Ticker (TargetAllocation)

- (int)balanceNumberOfShares {
    
    int numOfShares = @(roundf(([self calculateOwnedAmount] - [self calculateOwnedAmount])/self.sharePrice)).intValue;
    return numOfShares;
}

@end
