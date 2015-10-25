//
//  PortfolioUtility.h
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PortfolioUtility : NSObject

+ (NSDictionary *)getResponseFromJSONFileName:(NSString *)filename;

@end
