//
//  UserDetailInfoController.h
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailInfoController.h"
#import "UserInfoViewController.h"

@interface UserDetailInfoController : UITableViewController

@property (nonatomic, assign) UserInfoViewController *rootController;

@property (nonatomic, weak) IBOutlet UILabel *favoriteCountField;

@property (nonatomic, weak) IBOutlet UILabel *fansCountfield;
@property (nonatomic, weak) IBOutlet UILabel *followersCountField;

@property (nonatomic, weak) IBOutlet UILabel *fromField;
@property (nonatomic, weak) IBOutlet UILabel *joinTimeField;
@property (nonatomic, weak) IBOutlet UILabel *devPlatformField;
@property (nonatomic, weak) IBOutlet UILabel *expertiseField;

- (void)setFavoriteCount:(NSInteger)favoriteCount andFansCount:(NSInteger)fansCount andFollowersCount:(NSInteger)followersCount andFrom:(NSString*)from andJoinTime:(NSString*)joinTime andDevPlatform:(NSString*)devPlatform andExpertise:(NSString*)expertise;
@end
