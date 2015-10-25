//
//  TargetAllocationStrategy.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <PortfolioRebalancing/Portfolio.h>
#import "PortfolioRebalanceStrategy.h"
#import "Portfolio.h"

@interface TargetAllocationStrategy : NSObject

//@property (strong, nonatomic) NSMutableArray *portfolioTickers;

@property (strong, nonatomic) Portfolio *portfolio;

- (instancetype)initWithPortfolio:(Portfolio *)portfolio;
- (NSString*)getRebalancedAllocation;

@end
