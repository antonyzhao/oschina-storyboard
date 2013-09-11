//
//  Favorite.m
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "Favorite.h"

@implementation Favorite

- (id)initWithObjID:(int)nObjID andType:(int)nType andTitle:(NSString*)nTitle andUrl:(NSString*)nUrl
{
    self = [super init];
    if(self){
        self.objID = nObjID;
        self.type = nType;
        self.title = nTitle;
        self.url = nUrl;
    }
    return self;
}
- (id)initWithXMLElt:(TBXMLElement*)elt
{
    TBXMLElement *objIDElt = [TBXML childElementNamed:@"objid" parentElement:elt];
    TBXMLElement *typeElt = [TBXML childElementNamed:@"type" parentElement:elt];
    TBXMLElement *titleElt = [TBXML childElementNamed:@"title" parentElement:elt];
    TBXMLElement *urlElt = [TBXML childElementNamed:@"url" parentElement:elt];
    Favorite *fav = [[Favorite alloc] initWithObjID:[TBXML textForElement:objIDElt].intValue andType:[TBXML textForElement:typeElt].intValue andTitle:[TBXML textForElement:titleElt] andUrl:[TBXML textForElement:urlElt]];
    return fav;
}
@end
