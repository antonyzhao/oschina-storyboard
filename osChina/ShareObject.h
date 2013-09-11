//
//  ShareObject.h
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareObject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

- (id)initWithTitle:(NSString*)nTitle andUrl:(NSString*)nUrl;
@end
