//
//  PostViewController.h
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)segmentChanged:(id)sender;
@end
