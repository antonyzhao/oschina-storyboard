//
//  RelativeNews.h
//  osChina
//
//  Created by health on 13-9-2.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelativeNews : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;

- (id)initWithUrl:(NSString*)nUrl andTitle:(NSString*)nTitle;
- (id)initWithElt:(TBXMLElement*)elt;
@end
