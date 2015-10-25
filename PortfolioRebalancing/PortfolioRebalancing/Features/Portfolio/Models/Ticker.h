//
//  Ticker.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticker : NSObject

@property (weak, nonatomic) NSString *tickerSymbol;
@property (nonatomic) NSUInteger sharesOwned;
@property (nonatomic) float percentTargetAllocation;
@property (nonatomic) float actualAllocation;
@property (nonatomic) float sharePrice;
@property (nonatomic) float desiredTargetAmount;

- (instancetype)initTicker:(NSString*)ticker sharesOwned:(NSUInteger)sharesOwned percentTargetAllocation:(float)targetAllocation;
- (float)calculateOwnedAmount;
- (int)balanceNumberOfShares;

@end
