//
//  MyThread.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "MyThread.h"
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"
#import "ASIFormDataRequest.h"

static MyThread *instance;
@implementation MyThread

+ (MyThread*)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MyThread new];
    });
    return instance;
}
#pragma mark - Instance Methods
- (void)startNotice
{
    if(self.isRunning){
        return;
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
        self.isRunning = YES;
    }
}
- (void)startUpdatePortrait:(NSData*)imgData
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_userinfo_update]];
    request.useCookiePersistence = [Config instance].isCookie;
    [request setPostValue:[NSString stringWithFormat:@"%d",[Config instance].getUID] forKey:@"uid"];
    [request addData:imgData withFileName:@"img.jpg" andContentType:@"image/jpg" forKey:@"portrait"];
    request.delegate = self;
    request.tag = 11;
    [request startAsynchronous];
}
#pragma mark - Private Methods
- (void)timerUpdate
{
    NSString *url = [NSString stringWithFormat:@"%@?uid=%d",api_user_notice,[Config instance].getUID];
    [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [Tool getOSCNoticeFromString:operation.responseString];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - ASIRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [Tool getOSCNoticeFromRequest:request];
    if(request.hud){
        [request.hud hide:YES];
    }
    ApiError *error = [Tool getApiErrorFromRequest:request];
    switch (error.errorCode) {
        case 1:
        {
            NSLog(@"更新头像成功");
            UIView *view = [UIApplication sharedApplication].keyWindow;
            [Tool ToastNotification:@"成功更新您的头像" andView:view andLoading:NO andIsBottom:YES];
        }
            break;
        case 0:
        case  -2:
        case -1:
        {
            NSLog(@"后台发送动弹图片失败,%@,%d",error.errorMsg,error.errorCode);
        }
        default:
            break;
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}
@end
