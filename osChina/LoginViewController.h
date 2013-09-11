//
//  LoginViewController.h
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UIWebViewDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UISwitch *rememberField;
@property (nonatomic, weak) IBOutlet UIWebView *webView;

- (IBAction)login:(id)sender;
- (IBAction)bgTouched:(id)sender;
@end
