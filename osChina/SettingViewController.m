//
//  SettingViewController.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

- (void)_refresh;
@end

@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [notificationCenter postNotificationName:kNotificationLogin object:[Config instance].isCookie ? @"1" : @"0"];
    [self _refresh];
    [super viewDidAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    BOOL isLogin = [Config instance].isLogin;
    self.loginField.text = isLogin ? @"我的资料 (收藏/关注/粉丝)" : @"登录";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [notificationCenter removeObserver:self name:kNotificationLogin object:nil];
}
#pragma mark - Private Methods
- (void)_refresh
{
    self.loginField.text = [Config instance].isCookie ? @"我的资料 (收藏/关注/粉丝)" : @"登录";
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (cell.tag) {
        case 1:
        {
            if(![Config instance].isCookie){
                [self performSegueWithIdentifier:@"ShowLogin" sender:nil];
            }else{
                [self performSegueWithIdentifier:@"ShowUserInfo" sender:nil];
            }
        }
            break;
        case 2:
        {
            if([Config instance].isCookie == NO){
                [Tool ToastNotification:@"错误：您还没有登录，注销无效" andView:self.view andLoading:NO andIsBottom:NO];
                return;
            }
            [ASIHTTPRequest setSessionCookies:nil];
            [ASIHTTPRequest clearSession];
            [Config instance].isLogin = NO;
            [[Config instance] saveCookie:NO];
            
            [self _refresh];
            
            [notificationCenter postNotificationName:kNotificationLogin object:@"0"];
            [Tool ToastNotification:@"注销成功" andView:self.view andLoading:NO andIsBottom:NO];
        }
        default:
            break;
    }
}

@end
