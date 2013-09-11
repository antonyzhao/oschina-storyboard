//
//  Tool.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "Tool.h"
#import "GCDiscreetNotificationView.h"
#import "UncaughtExceptionHandler.h"
#import "News.h"
#import "RelativeNews.h"
#import "NewsDetailController.h"
#import "NewsCommentController.h"

@implementation Tool

+ (NSString*)getOSVersion
{
    return [NSString stringWithFormat:@"OSChina.NET/%@/%@/%@/%@",AppVersion,curDevice.systemName,curDevice.systemVersion,curDevice.model];
}
+ (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}
+ (UIColor *)getCellBackgroundColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}

+ (void)clearWebViewBackground:(UIWebView*)webView
{
    for(id view in webView.subviews){
        if([view isKindOfClass:[UIScrollView class]]){
            [view setBounces:NO];
        }
    }
}
+ (void)cancelRequest:(ASIHTTPRequest*)request
{
    if(request){
        [request cancel];
        [request clearDelegatesAndCancel];
    }
}
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom
{
    GCDiscreetNotificationView *notificationView = [[GCDiscreetNotificationView alloc] initWithText:text showActivity:isLoading inPresentationMode:isBottom ? GCDiscreetNotificationViewPresentationModeBottom : GCDiscreetNotificationViewPresentationModeTop inView:view];
    [notificationView show:YES];
    [notificationView hideAnimatedAfter:2.6];
}
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud
{
    [view addSubview:hud];
    hud.labelText = text;
    hud.square = YES;
    [hud show:YES];
}
+ (NSString*)intervalSinceNow:(NSString*)theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    else if (cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    else
    {
        //        timeString = [NSString stringWithFormat:@"%d-%"]
        NSArray *array = [theDate componentsSeparatedByString:@" "];
        //        return [array objectAtIndex:0];
        timeString = [array objectAtIndex:0];
    }
    return timeString;
}
+ (BOOL)isRepeatFavorite:(Favorite*)fav inArray:(NSMutableArray*)favs
{
    if(favs == nil){
        return NO;
    }
    for(Favorite *f in favs){
        if(f.objID == fav.objID && f.type == fav.type){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)analysisURL:(NSString*)url withNavController:(UINavigationController*)navController
{
    NSString *search = @"oschina.net";
    NSRange range = [url rangeOfString:search];
    if(range.length <= 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return NO;
    }else{
        url = [url substringFromIndex:7];
        NSString *prefix = [url substringToIndex:3];
        
        if([prefix isEqualToString:@"my."]){// 博客、动弹、个人专页
            NSArray *array = [url componentsSeparatedByString:@"/"];
            //个人专页 用户名形式
            if(array.count <= 2){
                
                return YES;
            }
        }else if([prefix isEqualToString:@"www"]){// 新闻、软件、问答
            NSArray *array = [url componentsSeparatedByString:@"/"];
            int count = array.count;
            if(count >= 3){
                NSString *type = array[1];
                if([type isEqualToString:@"news"]){
                    int newsID = [array[2] intValue];
                    News *news = [[News alloc] init];
                    news._id = newsID;
                    news.newsType = 0;
                    [Tool pushNewsDetail:news inNavController:navController andIsNextPage:YES];
                    return YES;
                }else if([type isEqualToString:@"p"]){
                    News *news = [[News alloc] init];
                    news.newsType = 1;
                    news.attachment = array[2];
                    [Tool pushNewsDetail:news inNavController:navController andIsNextPage:NO];
                    return YES;
                }else if([type isEqualToString:@"question"]){
                    
                }
            }
        }
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",url]]];
    return NO;
}
+ (void)pushNewsDetail:(News*)news inNavController:(UINavigationController*)navController andIsNextPage:(BOOL)nIsNextPage
{
    switch (news.newsType) {
        case 0://标准新闻
        {
            UITabBarController *newsDetailRootController = ViewControllerFromStoryboard(@"NewsDetailRootController");
            NewsDetailController *detailController = (NewsDetailController*)newsDetailRootController.viewControllers[0];
            detailController.newsID = news._id;
            detailController.isNextPage = nIsNextPage;
            
            NewsCommentController *commentController = (NewsCommentController*)newsDetailRootController.viewControllers[1];
            
            [navController pushViewController:newsDetailRootController animated:YES];
        }

            break;
        case 1://软件
            
            break;
        case 2://问答
            
            break;
        case 3://博客
            
            break;
        default:
            break;
    }
}
+ (int)isListOverFromRequest:(ASIHTTPRequest*)request
{
    return [Tool isListOverFromString:request.responseString];
}
+ (int)isListOverFromString:(NSString*)response
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *pageSizeElt = [TBXML childElementNamed:@"pagesize" parentElement:root];
    int size = [TBXML textForElement:pageSizeElt].intValue;
    return size;
}
+ (OSCNotice*)getOSCNoticeFromRequest:(ASIHTTPRequest*)request
{
    return [self getOSCNoticeFromString:request.responseString];
}
+ (OSCNotice*)getOSCNoticeFromString:(NSString*)response
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    
    if(!root){
        return nil;
    }
    TBXMLElement *notice = [TBXML childElementNamed:@"notice" parentElement:root];
    if(!notice){
        [Config instance].isLogin = NO;
        [notificationCenter postNotificationName:kNotificationLogin object:@"0"];
        return nil;
    }else{
        [notificationCenter postNotificationName:kNotificationLogin object:@"1"];
        [Config instance].isLogin = YES;
    }
    TBXMLElement *atmeElt = [TBXML childElementNamed:@"atmeCount" parentElement:notice];
    TBXMLElement *msgElt = [TBXML childElementNamed:@"msgCount" parentElement:notice];
    TBXMLElement *reviewElt = [TBXML childElementNamed:@"reviewCount" parentElement:notice];
    TBXMLElement *newFansElt = [TBXML childElementNamed:@"newFansCount" parentElement:notice];
    OSCNotice *osc = [[OSCNotice alloc] initWithAtmeCount:[TBXML textForElement:atmeElt].intValue andMsgCount:[TBXML textForElement:msgElt].intValue andReviewCount:[TBXML textForElement:reviewElt].intValue andNewFansCount:[TBXML textForElement:newFansElt].intValue];
    [notificationCenter postNotificationName:kNotificationNoticeUpdate object:osc];
    return osc;
}
+ (ApiError*)getApiErrorFromRequest:(ASIHTTPRequest*)request
{
    return [self getApiErrorFromString:request.responseString];
}
+ (ApiError*)getApiErrorFromString:(NSString*)response
{
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        if(root == nil){
            return nil;
        }
        TBXMLElement *result = [TBXML childElementNamed:@"result" parentElement:root
                                ];
        if(result == nil){
            return nil;
        }
        TBXMLElement *errorCodeElt = [TBXML childElementNamed:@"errorCode" parentElement:result];
        TBXMLElement *errorMsgElt = [TBXML childElementNamed:@"errorMessage" parentElement:result];
        
        return [[ApiError alloc] initWithErrorCode:[TBXML textForElement:errorCodeElt].intValue andErrorMsg:[TBXML textForElement:errorMsgElt]];
    }
    @catch (NSException *exception) {
        [UncaughtExceptionHandler takeException:exception];
        return [[ApiError alloc] initWithErrorCode:-1 andErrorMsg:@"出现异常"];
    }
    @finally {
        
    }
}
+ (SingleNews*)readStrNewsDetail:(NSString*)str
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:str error:nil];
    TBXMLElement *rootElt = xml.rootXMLElement;
    TBXMLElement *newsElt = [TBXML childElementNamed:@"news" parentElement:rootElt];
    if(newsElt == nil){
        return nil;
    }    
    return [[SingleNews alloc] initWithElement:newsElt];
}
+ (NSMutableArray*)getRelativeNews:(TBXMLElement*)elt
{
    TBXMLElement *relatives = [TBXML childElementNamed:@"relatives" parentElement:elt];
    if(relatives){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        TBXMLElement *relative = [TBXML childElementNamed:@"relative" parentElement:relatives];
        RelativeNews *relativeNews = [[RelativeNews alloc] initWithElt:relative];
        [array addObject:relativeNews];
        while (relative) {
            relative = [TBXML nextSiblingNamed:@"relative" searchFromElement:relatives];
            if(relative){
                relativeNews = [[RelativeNews alloc] initWithElt:relative];
                [array addObject:relativeNews];
            }
        }
        return array;
    }
    return nil;
}
+ (NSString*)generateRelativeNewsString:(NSArray*)array
{
    if(array == nil || array.count == 0){
        return @"";
    }
    NSString *middle = @"";
    for(RelativeNews *news in array){
        middle = [NSString stringWithFormat:@"%@<a href=%@ style='text-decoration:none'>%@</a><p/>",middle,news.url,news.title];
    }
    return [NSString stringWithFormat:@"<hr/>相关文章<div style='font-size:14px'><p/>%@</div>",middle];
}
+ (NSString*)getHTMLString:(NSString*)html
{
    return html;
}
+ (void)saveCacheWithType:(int)nType andID:(int)nID andString:(NSString*)str
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",nType,nID];
    [settings setObject:str forKey:key];
    [settings synchronize];
}
+ (NSString*)cacheWityType:(int)nType andID:(int)nID
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",nType,nID];
    return [settings objectForKey:key];
}
@end
