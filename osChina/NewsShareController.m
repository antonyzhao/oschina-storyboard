//
//  NewsShareViewController.m
//  osChina
//
//  Created by health on 13-8-30.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "NewsShareController.h"
#import "ShareObject.h"

@interface NewsShareController ()
{
}
@end

@implementation NewsShareController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [Tool getBackgroundColor];
    UITapGestureRecognizer *tapGestureByQQ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_shareByQQ:)];
    [self.shareQQField addGestureRecognizer:tapGestureByQQ];
    
    UITapGestureRecognizer *tapGestureBySina = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_shareBySina:)];
    [self.shareSinaFIeld addGestureRecognizer:tapGestureBySina];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)_shareByQQ:(UITapGestureRecognizer*)tapGesture
{
    NSString *share_url = @"http://share.v.t.qq.com/index.php?c=share&a=index";
    NSString *share_Source = @"OSChina";
    NSString *share_Site = @"OSChina.NET";
    NSString *share_AppKey = @"96f54f97c4de46e393c4835a266207f4";
    
    if ([Config instance].shareObject) {
        NSString *all = [NSString stringWithFormat:@"%@&title=%@&url=%@&appkey=%@&source=%@&site=%@",
                         share_url,
                         [[Config instance].shareObject.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [[Config instance].shareObject.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         share_AppKey,
                         share_Source,
                         share_Site];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:all]];
    }
}
- (void)_shareBySina:(UITapGestureRecognizer*)tapGesture
{
    NSString *share_url = @"http://v.t.sina.com.cn/share/share.php";
    if ([Config instance].shareObject) {
        NSString *all = [NSString stringWithFormat:@"%@?appkey=%@&title=%@&url=%@",
                         share_url,
                         SinaAppKey,
                         [[Config instance].shareObject.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         [[Config instance].shareObject.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:all]];
    }
}
@end
