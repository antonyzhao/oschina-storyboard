//
//  RootViewController.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    NSInteger _lastTabIndex;
}
@end

@implementation RootViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tabBarController double click
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    int newTabIndex = self.selectedIndex;
    if(newTabIndex == _lastTabIndex){
        [notificationCenter postNotificationName:kNotificationTabBarTapClick object:[NSString stringWithFormat:@"%d",newTabIndex]];
    }else{
        _lastTabIndex = newTabIndex;
    }
}
@end
