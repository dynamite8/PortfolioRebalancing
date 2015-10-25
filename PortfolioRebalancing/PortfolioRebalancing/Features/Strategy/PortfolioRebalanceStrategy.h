//
//  PortfolioRebalanceStrategy.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PortfolioRebalanceStrategy;

@protocol PortfolioRebalanceStrategyDelegate <NSObject>

@required
- (NSString*)getRebalancedAllocation;

@end

@interface PortfolioRebalanceStrategy : NSObject

@end
