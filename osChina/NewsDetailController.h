//
//  NewsDetailController.h
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleNews;
@interface NewsDetailController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, assign) BOOL isNextPage;
@property (nonatomic, assign) int newsID;

@property (nonatomic, strong) SingleNews *singleNews;
@end
