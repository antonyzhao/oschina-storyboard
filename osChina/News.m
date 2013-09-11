//
//  News.m
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "News.h"

@implementation News

- (id)initWithID:(int)newID andTitle:(NSString*)nTitle andUrl:(NSString*)nUrl andAuthor:(NSString*)nAuthor andAuthorID:(int)nAuthorID andPubDate:(NSString*)nPubDate andCommentCount:(int)nCommentCount
{
    self = [super init];
    if(self){
        self._id = newID;
        self.title = nTitle;
        self.url = nUrl;
        self.author = nAuthor;
        self.authorID = nAuthorID;
        self.pubDate = nPubDate;
        self.commentCount = nCommentCount;
    }
    return self;
}
- (id)initWithElt:(TBXMLElement*)elt
{
    
}
@end
