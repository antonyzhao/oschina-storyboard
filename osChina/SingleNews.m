//
//  SingleNews.m
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "SingleNews.h"

@implementation SingleNews

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
     andFavorite:(BOOL)nFavorite
{
    self = [super init];
    if(self){
        self._id = nID;
        self.title = nTitle;
        self.url = nUrl;
        self.body = nBody;
        self.author = nAuthor;
        self.authorID = nAuthorID;
        self.pubDate = nPubDate;
        self.commentCount = nCommentCount;
        self.releatives = nReleatives;
        self.softwareLink = nSoftwareLink;
        self.softwareName = nSoftwareName;
        self.favorite = nFavorite;
    }
    return self;
}
- (id)initWithElement:(TBXMLElement *)elt
{
    TBXMLElement *idElt = [TBXML childElementNamed:@"id" parentElement:elt];
    TBXMLElement *titleElt = [TBXML childElementNamed:@"title" parentElement:elt];
    TBXMLElement *urlElt = [TBXML childElementNamed:@"url" parentElement:elt];
    TBXMLElement *bodyElt = [TBXML childElementNamed:@"body" parentElement:elt];
    TBXMLElement *authorElt = [TBXML childElementNamed:@"author" parentElement:elt];
    TBXMLElement *authorIDElt = [TBXML childElementNamed:@"authorid" parentElement:elt];
    TBXMLElement *pubDate = [TBXML childElementNamed:@"pubdate" parentElement:elt];
    TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:elt];
    TBXMLElement *softwareLinkElt = [TBXML childElementNamed:@"softwarelink" parentElement:elt];
    TBXMLElement *softwareNameElt = [TBXML childElementNamed:@"softwarename" parentElement:elt];
    TBXMLElement *favoriteEltsl = [TBXML childElementNamed:@"favorite" parentElement:elt];
    
    NSMutableArray *relatives = [Tool getRelativeNews:elt];
    
    return [self initWithID:[TBXML textForElement:idElt].intValue andTitle:[TBXML textForElement:titleElt] andUrl:[TBXML textForElement:urlElt] andBody:[TBXML textForElement:bodyElt] andAuthor:[TBXML textForElement:authorElt] andAuthorID:[TBXML textForElement:authorIDElt].intValue andPubDate:[TBXML textForElement:pubDate] andCommentCount:[TBXML textForElement:commentCount].intValue andRelatives:relatives andSoftwareLink:[TBXML textForElement:softwareLinkElt] andSoftwareName:[TBXML textForElement:softwareNameElt] andFavorite:[TBXML textForElement:favoriteEltsl].boolValue];
}
@end
