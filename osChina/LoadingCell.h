//
//  LoadingCell.h
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *displayField;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingField;
@end
