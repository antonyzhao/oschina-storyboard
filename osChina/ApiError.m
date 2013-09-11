//
//  ApiError.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "ApiError.h"

@implementation ApiError

- (id)initWithErrorCode:(int)nErrorCode andErrorMsg:(NSString*)nErrorMsg
{
    self = [super init];
    if(self){
        self.errorCode = nErrorCode;
        self.errorMsg = nErrorMsg;
    }
    return self;
}
@end
