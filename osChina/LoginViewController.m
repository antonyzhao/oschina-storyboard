//
//  LoginViewController.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "UncaughtExceptionHandler.h"
#import "ApiError.h"
#import "MyThread.h"

@interface LoginViewController ()
{
    ASIFormDataRequest *_request;
    BOOL _isPopByNotice;
}
- (void)_analyseUserInfo:(NSString*)xml;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [Tool clearWebViewBackground:self.webView];
    
    NSString *username = [Config instance].getUsername;
    NSString *password = [Config instance].getPassword;
    if(username && ![username isEqualToString:@""]){
        self.usernameField.text = username;
    }
    if(password && ![password isEqualToString:@""]){
        self.passwordField.text = password;
    }
    
    self.view.backgroundColor = [Tool getBackgroundColor];
    self.webView.backgroundColor = [Tool getBackgroundColor];
    NSString *html = @"<body style='background-color:#EBEBF3'>1, 您可以在 <a href='http://www.oschina.net'>http://www.oschina.net</a> 上免费注册一个账号用来登陆<p />2, 如果您的账号是使用OpenID的方式注册的，那么建议您在网页上为账号设置密码<p />3, 您可以点击 <a href='http://www.oschina.net/question/12_52232'>这里</a> 了解更多关于手机客户端登录的问题</body>";
    [self.webView loadHTMLString:html baseURL:nil];
    self.webView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [Tool cancelRequest:_request];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)_analyseUserInfo:(NSString*)xml
{
    @try {
        TBXML *_xml = [[TBXML alloc] initWithXMLString:xml error:nil];
        TBXMLElement *root = _xml.rootXMLElement;
        TBXMLElement *userElt = [TBXML childElementNamed:@"user" parentElement:root];
        TBXMLElement *uidElt = [TBXML childElementNamed:@"uid" parentElement:userElt];
        
        [[Config instance] saveUID:[[TBXML textForElement:uidElt] intValue]];
    }
    @catch (NSException *exception) {
        [UncaughtExceptionHandler takeException:exception];
    }
    @finally {
        
    }
}

#pragma mark - Instance Methods
- (IBAction)login:(id)sender
{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    if(username.length * password.length != 0){
        _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_login_validate]];
        _request.useCookiePersistence = YES;
        [_request setPostValue:username forKey:@"username"];
        [_request setPostValue:password forKey:@"pwd"];
        [_request setPostValue:@"1" forKey:@"keep_login"];
        _request.delegate = self;
        [_request startAsynchronous];
        
        _request.hud = [[MBProgressHUD alloc] initWithView:self.view];
        [Tool showHUD:@"正在登录" andView:self.view andHUD:_request.hud];
    }
}
- (IBAction)bgTouched:(id)sender
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.usernameField){
        [self.passwordField becomeFirstResponder];
    }else if(textField == self.passwordField){
        [self login:nil];
    }
    return YES;
}
#pragma mark - WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [[UIApplication sharedApplication] openURL:request.URL];
    if([request.URL.absoluteString isEqualToString:@"about:blank"]){
        return YES;
    }
    return NO;
}
#pragma mark - ASIFormDataRequest Delegate
- (void)requestFailed:(ASIHTTPRequest*)request
{
    if(_request.hud){
        [_request.hud hide:YES];
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if(_request.hud){
        [_request.hud hide:YES];
    }
    [Tool getOSCNoticeFromRequest:_request];
    _request.useCookiePersistence = YES;
    ApiError *error = [Tool getApiErrorFromRequest:_request];
    if(error == nil){
        [Tool ToastNotification:request.responseString andView:self.view andLoading:NO andIsBottom:NO];
    }
    switch (error.errorCode) {
        case 1:
        {
            [[Config instance] saveCookie:YES];
            if(_isPopByNotice == NO){
                [self.navigationController popViewControllerAnimated:YES];
            }
            if(self.rememberField.isOn){
                [[Config instance] saveUsername:self.usernameField.text andPassword:self.passwordField.text];
            }else{
                [[Config instance] saveUsername:@"" andPassword:@""];
            }
            NSLog(@"error ----%s---%d",__FUNCTION__,__LINE__);
            if([Config instance].viewBeforeLogin && [[Config instance].viewNameBeforeLogin isEqualToString:@""]){
                
            }
            [self _analyseUserInfo:_request.responseString];
            if(_isPopByNotice){
                [self.navigationController popViewControllerAnimated:YES];
            }
            [[MyThread instance] startNotice];
        }
            break;
        case 0:
        case -1:
        {
            [Tool ToastNotification:[NSString stringWithFormat:@"错误:%@",error.errorMsg] andView:self.view andLoading:NO andIsBottom:NO];
        }
        default:
            break;
    }
}
@end
