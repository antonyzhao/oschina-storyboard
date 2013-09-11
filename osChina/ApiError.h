//
//  ApiError.h
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiError : NSObject

@property (nonatomic, assign) int errorCode;
@property (nonatomic, strong) NSString *errorMsg;

- (id)initWithErrorCode:(int)nErrorCode andErrorMsg:(NSString*)nErrorMsg;
@end
