//
//  Favorite.h
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface Favorite : NSObject

@property (nonatomic, assign) int objID;
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

- (id)initWithObjID:(int)nObjID andType:(int)nType andTitle:(NSString*)nTitle andUrl:(NSString*)nUrl;
- (id)initWithXMLElt:(TBXMLElement*)elt;
@end
