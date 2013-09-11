//
//  CommentCount.m
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "CommentCount.h"

@implementation CommentCount

- (id)initWithAttachment:(id)nAttachment andCommentCount:(int)nCommentCount
{
    self = [super init];
    if(self){
        self.attachment = nAttachment;
        self.commentCount = nCommentCount;
    }
    return self;
}
@end
