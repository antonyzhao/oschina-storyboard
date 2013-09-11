//
//  UserInfoViewController.h
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "SSPhotoCropperViewController.h"


@interface UserInfoViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,SSPhotoCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet EGOImageView *egoImgView;
@property (nonatomic, weak) IBOutlet UIImageView *genderImgView;
@property (nonatomic, weak) IBOutlet UILabel *nameField;

- (IBAction)updatePortrait:(id)sender;
@end
