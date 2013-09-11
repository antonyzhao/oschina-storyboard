//
//  SingleNews.h
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface SingleNews : NSObject

@property (nonatomic, assign) int _id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) int authorID;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, assign) int commentCount;
@property (nonatomic, strong) NSArray *releatives;
@property (nonatomic, strong) NSString *softwareLink;
@property (nonatomic, strong) NSString *softwareName;
@property (nonatomic, assign) BOOL favorite;

- (id)initWithID:(int)nID
        andTitle:(NSString*)nTitle
          andUrl:(NSString *)nUrl
         andBody:(NSString*)nBody
       andAuthor:(NSString *)nAuthor
     andAuthorID:(int)nAuthorID
      andPubDate:(NSString *)nPubDate
 andCommentCount:(int)nCommentCount
    andRelatives:(NSArray*)nReleatives
 andSoftwareLink:(NSString*)nSoftwareLink
 andSoftwareName:(NSString*)nSoftwareName
     andFavorite:(BOOL)nFavorite;

- (id)initWithElement:(TBXMLElement*)elt;

@end
