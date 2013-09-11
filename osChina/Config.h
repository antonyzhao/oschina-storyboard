//
//  Config.h
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareObject;
@interface Config : NSObject

//是否已经登录
@property (nonatomic, assign) BOOL isLogin;
//是否具备网络连接
@property (nonatomic, assign) bool isNetworkRunning;
//当前被分享的文章标题和URL
@property (nonatomic, strong) ShareObject *shareObject;

@property (nonatomic, strong) UIViewController *viewBeforeLogin;
@property (nonatomic, strong) NSString *viewNameBeforeLogin;

+ (Config*)instance;

- (void)saveUsername:(NSString*)username andPassword:(NSString*)password;
- (NSString*)getIOSGuid;
- (void)saveCookie:(BOOL)cookie;
- (BOOL)isCookie;
-(void)saveUID:(int)uid;
- (int)getUID;
- (NSString*)getUsername;
- (NSString*)getPassword;
@end
