//
//  NewsDetailController.m
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "NewsDetailController.h"
#import "SingleNews.h"
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"
#import "CommentCount.h"
#import "ShareObject.h"

@interface NewsDetailController ()
{
    UIBarButtonItem *_favoriteItem;
}
@end

@implementation NewsDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - View Lifecycle
- (void)viewDidAppear:(BOOL)animated
{
    if(self.singleNews){
        [self _refreshFavorite:self.singleNews];
    }
    [super viewDidAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.webView loadHTMLString:@"" baseURL:nil];
    [Tool clearWebViewBackground:self.webView];
    
    _favoriteItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏此文" style:UIBarButtonItemStyleBordered target:self action:@selector(_changeFavorite:)];
    self.parentViewController.title = @"资讯详情";
    self.parentViewController.navigationItem.rightBarButtonItem = _favoriteItem;
//    self.navigationItem.rightBarButtonItem = _favoriteItem;
    
    self.singleNews = [[SingleNews alloc] init];
    if([Config instance].isNetworkRunning){
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [Tool showHUD:@"正在加载" andView:self.view andHUD:hud];
        
        NSString *url = [NSString stringWithFormat:@"%@?id=%d",api_news_detail,self.newsID];
        [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [Tool getOSCNoticeFromString:operation.responseString];
            [hud setHidden:YES];
            
            self.singleNews = [Tool readStrNewsDetail:operation.responseString];
            if(self.singleNews == nil){
                [Tool ToastNotification:@"加载失败" andView:self.view andLoading:NO andIsBottom:NO];
                return;
            }
            [self _loadData:self.singleNews];
            if([Config instance].isNetworkRunning){
                [Tool saveCacheWithType:1 andID:self.singleNews._id andString:operation.responseString];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud hide:YES];
            if([Config instance].isNetworkRunning){
                [Tool ToastNotification:@"错误：网络无连接" andView:self.view andLoading:NO andIsBottom:NO];
            }
        }];
    }else{
        NSString *value = [Tool cacheWityType:1 andID:self.newsID];
        if(value){
            self.singleNews = [Tool readStrNewsDetail:value];
            [self _loadData:self.singleNews];
        }else{
            [Tool ToastNotification:@"错误：网络无连接" andView:self.view andLoading:NO andIsBottom:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.webView stopLoading];
}

#pragma mark - Private Methods
- (void)_loadData:(SingleNews*)singleNews
{
    [self _refreshFavorite:singleNews];
    //发送通知修改新闻评论数目
    CommentCount *commentCount = [[CommentCount alloc] initWithAttachment:self andCommentCount:singleNews.commentCount];
    [notificationCenter postNotificationName:kNotificationDetailCommentCount object:commentCount];
    
    //新闻，用于微博分享
    [Config instance].shareObject = [[ShareObject alloc] initWithTitle:singleNews.title andUrl:singleNews.url];
    
    NSString *authorStr = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a> 发布于 %@",singleNews.authorID,singleNews.author,singleNews.pubDate];
    NSString *software = @"";
    if([singleNews.softwareName isEqualToString:@""] == NO){
        software = [NSString stringWithFormat:@"<div id='oschina_software' style='margin-top:8px;color:#FF0000;font-size:14px;font-weight:bold'>更多关于:&nbsp;<a href='%@'>%@</a>&nbsp;的详细信息</div>",singleNews.softwareLink, singleNews.softwareName];
    }
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, singleNews.title,authorStr, singleNews.body,software,[Tool generateRelativeNewsString:singleNews.releatives],HTML_Bottom];
    NSString *result = [Tool getHTMLString:html];
    [self.webView loadHTMLString:result baseURL:nil];
}
- (void)_refreshFavorite:(SingleNews*)singleNews
{
    if(self.isNextPage){
        
    }
    _favoriteItem.title = singleNews.favorite ? @"取消收藏" : @"收藏此文";
}
- (void)_changeFavorite:(UIBarButtonItem*)item
{
    BOOL isFav = [item.title isEqualToString:@"收藏此文"];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [Tool showHUD:isFav ? @"正在添加收藏" : @"正在取消收藏" andView:self.view andHUD:hud];
    [[AFOSCClient sharedClient] getPath:isFav ? api_favorite_add : api_favorite_delete  parameters:@{@"uid":@([Config instance].getUID),@"objid":@(self.newsID),@"type":@"4"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        [Tool getOSCNoticeFromString:operation.responseString];
        
        ApiError *error = [Tool getApiErrorFromString:operation.responseString];
        if(error == nil){
            [Tool ToastNotification:operation.responseString andView:self.view andLoading:NO andIsBottom:NO];
            return;
        }
        switch (error.errorCode) {
            case 1:
                _favoriteItem.title = isFav ? @"取消收藏" : @"收藏此文";
                self.singleNews.favorite = !self.singleNews.favorite;
                break;
            case 0:
            case -1:
            case -2:
            {
                [Tool ToastNotification:[NSString stringWithFormat:@"错误 %@",error.errorMsg] andView:self.view andLoading:NO andIsBottom:NO];
            }
                break;
            default:
                break;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Tool ToastNotification:@"添加收藏失败" andView:self.view andLoading:NO andIsBottom:NO];
    }];
}
#pragma mark - WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [Tool analysisURL:[request.URL absoluteString] withNavController:self.parentViewController.navigationController];
    if([request.URL.absoluteString isEqualToString:@"about:blank"]){
        return YES;
    }else{
        return NO;
    }
}
@end
