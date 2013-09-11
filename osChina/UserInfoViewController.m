//
//  UserInfoViewController.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserDetailInfoController.h"
#import "MyThread.h"
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"
#import "UncaughtExceptionHandler.h"

@interface UserInfoViewController ()
{
    UserDetailInfoController *_detailInfoController;
}
@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self _reloadPersonInfo];
    _detailInfoController = ViewControllerFromStoryboard(@"UserDetailInfoController");
    _detailInfoController.rootController = self;
    _detailInfoController.view.frame = CGRectMake(0, 84, 320, 371);
    [self.view addSubview:_detailInfoController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Instance Methods
- (IBAction)updatePortrait:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"返回" otherButtonTitles:@"图库",@"拍照", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    if([@"图库" isEqualToString:title]){
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if([@"拍照" isEqualToString:title]){
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    SSPhotoCropperViewController *photoCropperController = [[SSPhotoCropperViewController alloc] initWithPhoto:image delegate:self uiMode:SSPCUIModePresentedAsModalViewController showsInfoButton:NO];
    photoCropperController.minZoomScale = .25f;
    photoCropperController.maxZoomScale = 4.0f;
    [self.navigationController pushViewController:photoCropperController animated:YES];
}

#pragma mark - PhotoCropper Delegate
- (void)photoCropper:(SSPhotoCropperViewController *)photoCropper didCropPhoto:(UIImage *)photo
{
    [self.navigationController popViewControllerAnimated:YES];
    [[MyThread instance] startUpdatePortrait:UIImageJPEGRepresentation(photo, .75f)];
    [Tool ToastNotification:@"正在上传您得头像" andView:self.view andLoading:YES andIsBottom:NO];
}
- (void)photoCropperDidCancel:(SSPhotoCropperViewController *)photoCropper
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods
- (void)_reloadPersonInfo
{
    NSString *url = [NSString stringWithFormat:@"%@?uid=%d",api_my_information,[Config instance].getUID];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [Tool showHUD:@"正在获取信息" andView:self.view andHUD:hud];
    
    [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        [Tool getOSCNoticeFromString:operation.responseString];
        @try {
            TBXML *xml = [[TBXML alloc] initWithXMLString:operation.responseString error:nil];
            TBXMLElement *root = xml.rootXMLElement;
            if(root == nil){
                [Tool ToastNotification:@"获取个人信息错误" andView:self.view andLoading:NO andIsBottom:NO];
                return;
            }
            TBXMLElement *user = [TBXML childElementNamed:@"user" parentElement:root];
            if(user == nil){
                [Tool ToastNotification:@"获取个人信息错误" andView:self.view andLoading:NO andIsBottom:NO];
                return;
            }
            
            TBXMLElement *nameElt = [TBXML childElementNamed:@"name" parentElement:user];
            TBXMLElement *portraitElt = [TBXML childElementNamed:@"portrait" parentElement:user];
            TBXMLElement *joinTimeElt = [TBXML childElementNamed:@"jointime" parentElement:user];
            TBXMLElement *genderElt = [TBXML childElementNamed:@"gender" parentElement:user];
            TBXMLElement *fromElt = [TBXML childElementNamed:@"from" parentElement:user];
            TBXMLElement *devPlatformElt = [TBXML childElementNamed:@"devplatform" parentElement:user];
            TBXMLElement *expertiseElt = [TBXML childElementNamed:@"expertise" parentElement:user];
            TBXMLElement *favoriteCountElt = [TBXML childElementNamed:@"favoritecount" parentElement:user];
            TBXMLElement *fansCountElt = [TBXML childElementNamed:@"fanscount" parentElement:user];
            TBXMLElement *followersCountElt = [TBXML childElementNamed:@"followerscount" parentElement:user];
            
            self.nameField.text = [TBXML textForElement:nameElt];
            NSString *portraitStr = [TBXML textForElement:portraitElt];
            if([@"" isEqualToString:portraitStr]){
                self.egoImgView.image = [UIImage imageNamed:@"big_avatar"];
            }else{
                self.egoImgView.imageURL = [NSURL URLWithString:portraitStr];
            }
            
            if([TBXML textForElement:genderElt].intValue == 1){
                self.genderImgView.image = [UIImage imageNamed:@"man"];
            }else{
                self.genderImgView.image = [UIImage imageNamed:@"woman"];
            }
            
            [_detailInfoController setFavoriteCount:[TBXML textForElement:favoriteCountElt].intValue andFansCount:[TBXML textForElement:fansCountElt].intValue andFollowersCount:[TBXML textForElement:followersCountElt].intValue andFrom:[TBXML textForElement:fromElt] andJoinTime:[TBXML textForElement:joinTimeElt] andDevPlatform:[TBXML textForElement:devPlatformElt] andExpertise:[TBXML textForElement:expertiseElt]];
        }
        @catch (NSException *exception) {
            [UncaughtExceptionHandler takeException:exception];
        }
        @finally {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        [Tool ToastNotification:@"网络连接错误" andView:self.view andLoading:NO andIsBottom:NO];
    }];
}
@end
