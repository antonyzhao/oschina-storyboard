//
//  MyThread.h
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyThread : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, strong) UIView *mainView;
+ (MyThread*)instance;

- (void)startNotice;
- (void)startUpdatePortrait:(NSData*)imgData;

@end
