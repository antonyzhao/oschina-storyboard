//
//  AFOSCClient.h
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFOSCClient : AFHTTPClient

+ (AFOSCClient*)sharedClient;
@end
