//
//  AFOSCClient.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "AFOSCClient.h"
#import "AFXMLRequestOperation.h"

#define kAFUrl  @"http://www.oschina.net/action/api/"

static AFOSCClient *sharedClient;
@implementation AFOSCClient

+ (AFOSCClient*)sharedClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[AFOSCClient alloc] initWithBaseURL:[NSURL URLWithString:kAFUrl]];
        [sharedClient setDefaultHeader:@"User-Agent" value:[NSString stringWithFormat:@"%@%@",[Tool getOSVersion],[Config instance].getIOSGuid]];
    });
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(self){
        [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}
@end
