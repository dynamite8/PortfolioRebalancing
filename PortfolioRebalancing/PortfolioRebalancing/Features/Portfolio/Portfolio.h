//
//  Portfolio.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Portfolio : NSObject

@property (strong, nonatomic) NSMutableArray *listOfTickers;
@property (strong, nonatomic) NSDictionary *listOfCurrentTickerPrice;

- (void)parseListOfTickersFromFile:(NSString*)filename;
- (NSString*)getRebalancedAllocation;

@end
