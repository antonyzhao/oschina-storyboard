//
//  RelativeNews.m
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "RelativeNews.h"

@implementation RelativeNews

- (id)initWithUrl:(NSString*)nUrl andTitle:(NSString*)nTitle
{
    self = [super init];
    if(self){
        self.url = nUrl;
        self.title = nTitle;
    }
    return self;
}
- (id)initWithElt:(TBXMLElement*)elt
{
    TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:elt];
    TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:elt];
    
    return [self initWithUrl:[TBXML textForElement:url] andTitle:[TBXML textForElement:title]];
}
@end
