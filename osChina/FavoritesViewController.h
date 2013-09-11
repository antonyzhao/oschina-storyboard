//
//  FavoritesViewController.h
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger catalog;

- (IBAction)segmentedControlChanged:(id)sender;

@end
