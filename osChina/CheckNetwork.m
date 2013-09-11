//
//  CheckNetwork.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"

@implementation CheckNetwork

+ (BOOL)isExistenceNetwork
{
    BOOL isExistence = YES;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.oschina.net"];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistence = NO;
            break;
        case ReachableViaWiFi:
            isExistence = YES;
            break;
        case ReachableViaWWAN:
            isExistence = YES;
            break;
        default:
            isExistence = YES;
            break;
    }
    return isExistence;
}
@end
