//
//  ShareObject.m
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "ShareObject.h"

@implementation ShareObject

- (id)initWithTitle:(NSString*)nTitle andUrl:(NSString*)nUrl
{
    self = [super init];
    if(self){
        self.title = nTitle;
        self.url = nUrl;
    }
    return self;
}
@end
