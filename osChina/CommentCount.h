//
//  CommentCount.h
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentCount : NSObject

@property (nonatomic, assign) id attachment;
@property (nonatomic, assign) int commentCount;

- (id)initWithAttachment:(id)nAttachment andCommentCount:(int)nCommentCount;
@end
