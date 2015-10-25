//
//  PortfolioManager.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-25.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Portfolio.h"

@interface PortfolioManager : NSObject

@property (strong, nonatomic) NSString * _Nonnull username;
@property (strong, nonatomic) Portfolio * _Nonnull portfolio;

+ (instancetype _Nonnull)sharedInstance;
+ (instancetype _Nonnull)initWithUsername:(NSString * _Nonnull)username;

- (instancetype _Nullable)init NS_UNAVAILABLE;
- (void)setupPorfolio:(NSString * _Nonnull)portfolioName;
- (NSString * _Nullable)getRebalanceTransactions;

@end
