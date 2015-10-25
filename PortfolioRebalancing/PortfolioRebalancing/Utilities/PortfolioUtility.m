//
//  PortfolioUtility.m
//  PortfolioRebalancing
//
//  Created by Jenny Chang Ho on 2015-10-24.
//  Copyright © 2015 TTGS. All rights reserved.
//

#import "PortfolioUtility.h"

@implementation PortfolioUtility

+ (NSDictionary *)getResponseFromJSONFileName:(NSString *)filename {
    
    NSString *path = [[NSBundle bundleWithIdentifier:@"com.ttgs.PortfolioRebalancing"] pathForResource:filename ofType:@"json"];
    
    if (!path) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error : %@", [error description]);
        return nil;
    }
    return responseDictionary;
}

@end
