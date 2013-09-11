//
//  NewsViewController.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "NewsViewController.h"
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"

@interface NewsViewController ()
{
    int _allCount;
    NSMutableArray *_news;
    BOOL _isLoadOver;
    BOOL _isLoading;
}
- (NSString*)_segmentTitle;
@end

@implementation NewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [Tool getBackgroundColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [notificationCenter addObserver:self selector:@selector(refreshed:) name:kNotificationTabBarTapClick object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [notificationCenter removeObserver:self name:kNotificationTabBarTapClick object:nil];
}
#pragma mark - Handle Refresh
- (void)refresh:(UIRefreshControl*)refreshControl
{
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark - Handle refreshed Notification
- (void)refreshed:(NSNotification*)notification
{
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark - Private Methods
- (NSString*)_segmentTitle
{
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            return @"咨询";
            break;
        case 1:
            return @"博客";
            break;
        case 2:
            return @"推荐阅读";
            break;
    }
    return @"";
}
- (void)_reloadType:(int)nCatalog
{
    self.catalog = nCatalog;
    [self _clear];
    [self.tableView reloadData];
    [self _reload:NO];
}
- (void)_clear
{
    _allCount = 0;
    [_news removeAllObjects];
    _isLoadOver = NO;
}
- (void)_reload:(BOOL)noRefresh
{
    if([Config instance].isNetworkRunning){
        if(_isLoadOver || _isLoading){
            return;
        }
        if(!noRefresh){
            _allCount = 0;
        }
        int pageIndex = _allCount / 20;
        NSString *url;
        switch (self.catalog) {
            case 1:
                url = [NSString stringWithFormat:@"%@?catalog=%d&pageIndex=%d&pageSize=%d", api_news_list, 1, pageIndex, 20];
                break;
            case 2:
                url = [NSString stringWithFormat:@"%@?type=latest&pageIndex=%d&pageSize=%d", api_blog_list, pageIndex, 20];
                break;
            case 3:
                url = [NSString stringWithFormat:@"%@?type=recommend&pageIndex=%d&pageSize=%d", api_blog_list, pageIndex, 20];
                break;
        }
        
        [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [Tool getOSCNoticeFromString:operation.responseString];
            _isLoading = NO;
            if(!noRefresh){
                [self _clear];
            }
            
            @try {
                
            }
            @catch (NSException *exception) {
                [UncaughtExceptionHandler takeException:exception];
            }
            @finally {
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
