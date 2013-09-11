//
//  NewsShareViewController.h
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsShareController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *shareSinaFIeld;
@property (nonatomic, weak) IBOutlet UIImageView *shareQQField;


@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *content;
@end
