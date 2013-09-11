//
//  UserDetailInfoController.m
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "UserDetailInfoController.h"

@interface UserDetailInfoController ()

@end

@implementation UserDetailInfoController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setFavoriteCount:(NSInteger)favoriteCount andFansCount:(NSInteger)fansCount andFollowersCount:(NSInteger)followersCount andFrom:(NSString*)from andJoinTime:(NSString*)joinTime andDevPlatform:(NSString*)devPlatform andExpertise:(NSString*)expertise
{
    self.favoriteCountField.text = [NSString stringWithFormat:@"收藏(%d)",favoriteCount];
    
    self.fansCountfield.text = [NSString stringWithFormat:@"粉丝(%d)",fansCount];
    
    self.followersCountField.text = [NSString stringWithFormat:@"关注(%d)",followersCount];
    
    NSString *joinTimeStr = [Tool intervalSinceNow:joinTime];
    self.joinTimeField.text = joinTimeStr;
    [self.joinTimeField sizeToFit];
    
    self.devPlatformField.text = devPlatform;
    [self.devPlatformField sizeToFit];
    
    self.expertiseField.text = expertise;
    [self.expertiseField sizeToFit];
    
    self.fromField.text = from;
    [self.fromField sizeToFit];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        [self.rootController performSegueWithIdentifier:@"ShowFavorite" sender:nil];
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            [self.rootController performSegueWithIdentifier:@"ShowFans" sender:nil];
        }else {
            [self.rootController performSegueWithIdentifier:@"ShowFollowers" sender:nil];
        }
    }
}

@end
