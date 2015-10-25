//
//  Portfolio.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Portfolio : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithPorfolioName:(NSString*)portfolioName;
@property (strong, nonatomic) NSMutableArray *listOfTickers;

@end
