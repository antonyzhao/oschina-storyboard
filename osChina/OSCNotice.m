//
//  OSCNotice.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "OSCNotice.h"

@implementation OSCNotice

- (id)initWithAtmeCount:(int)nAtmeCount andMsgCount:(int)nMsgCount andReviewCount:(int)nReviewCount andNewFansCount:(int)nNewFansCount
{
    self = [super init];
    if(self){
        self.atmeCount = nAtmeCount;
        self.msgCount = nMsgCount;
        self.reviewCount = nReviewCount;
        self.newFansCount = nNewFansCount;
    }
    return self;
}
@end
