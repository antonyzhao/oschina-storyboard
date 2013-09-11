//
//  OSCNotice.h
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSCNotice : NSObject

@property (nonatomic, assign) int atmeCount;
@property (nonatomic, assign) int msgCount;
@property (nonatomic, assign) int reviewCount;
@property (nonatomic, assign) int newFansCount;

- (id)initWithAtmeCount:(int)nAtmeCount andMsgCount:(int)nMsgCount andReviewCount:(int)nReviewCount andNewFansCount:(int)nNewFansCount;
@end
