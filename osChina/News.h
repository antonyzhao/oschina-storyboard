//
//  News.h
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface News : NSObject

@property (nonatomic, assign) int _id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) int authorID;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, assign) int commentCount;
@property (nonatomic, assign) int newsType;
@property (nonatomic, assign) int authorUID2;
@property (nonatomic, strong) NSString *attachment;

- (id)initWithID:(int)newID andTitle:(NSString*)nTitle andUrl:(NSString*)nUrl andAuthor:(NSString*)nAuthor andAuthorID:(int)nAuthorID andPubDate:(NSString*)nPubDate andCommentCount:(int)nCommentCount;
- (id)initWithElt:(TBXMLElement*)elt;
@end
