//
//  Tool.h
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "OSCNotice.h"
#import "ASIHTTPRequest.h"
#import "ApiError.h"
#import "Favorite.h"
#import "News.h"
#import "SingleNews.h"

@interface Tool : NSObject

+ (NSString*)getOSVersion;
+ (UIColor *)getBackgroundColor;
+ (UIColor *)getCellBackgroundColor;
+ (void)cancelRequest:(ASIHTTPRequest*)request;
+ (BOOL)isRepeatFavorite:(Favorite*)fav inArray:(NSMutableArray*)favs;
+ (OSCNotice*)getOSCNoticeFromRequest:(ASIHTTPRequest*)request;
+ (OSCNotice*)getOSCNoticeFromString:(NSString*)response;
+ (int)isListOverFromRequest:(ASIHTTPRequest*)request;
+ (int)isListOverFromString:(NSString*)response;
+ (ApiError*)getApiErrorFromRequest:(ASIHTTPRequest*)request;
+ (ApiError*)getApiErrorFromString:(NSString*)response;
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud;
+ (void)clearWebViewBackground:(UIWebView*)webView;
+ (NSString*)intervalSinceNow:(NSString*)dateStr;
+ (BOOL)analysisURL:(NSString*)url withNavController:(UINavigationController*)navController;
+ (void)pushNewsDetail:(News*)news inNavController:(UINavigationController*)navController andIsNextPage:(BOOL)nIsNextPage;

+ (SingleNews*)readStrNewsDetail:(NSString*)str;
+ (NSMutableArray*)getRelativeNews:(TBXMLElement*)elt;
+ (NSString*)generateRelativeNewsString:(NSArray*)array;
+ (NSString*)getHTMLString:(NSString*)html;

+ (void)saveCacheWithType:(int)nType andID:(int)nID andString:(NSString*)str;
+ (NSString*)cacheWityType:(int)nType andID:(int)nID;
@end
