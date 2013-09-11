//
//  FavoritesViewController.m
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "FavoritesViewController.h"
#import "ASIHTTPRequest.h"
#import "Favorite.h"
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"

@interface FavoritesViewController ()
{
    BOOL _isLoadOver;
    BOOL _isLoading;
    NSUInteger _allCount;
    NSMutableArray *_favorites;
}
@end

@implementation FavoritesViewController

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
    _favorites = [[NSMutableArray alloc] init];
    self.catalog = 1;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(_refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self _reload:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Instance Methods
- (IBAction)segmentedControlChanged:(id)sender
{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 1:
            self.catalog = 1;
            break;
        case 2:
            self.catalog = 2;
            break;
        case 3:
            self.catalog = 3;
            break;
        case 4:
            self.catalog = 4;
            break;
        default:
            break;
    }
    [self _clear];
    [self.tableView reloadData];
    [self _reload:NO];
}

#pragma mark - TableView Datasource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _favorites.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [Tool getCellBackgroundColor];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCellIdentifier"];
    Favorite *favorite = _favorites[indexPath.row];
    cell.textLabel.text = favorite.title;
    if(self.catalog != 5){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_favorites.count <= indexPath.row){
        [self performSelector:@selector(_reload:)];
    }else{
        Favorite *fav = _favorites[indexPath.row];
        [Tool analysisURL:fav.url withNavController:self.navigationController];
    }
}
#pragma mark - Private Methods
- (void)_refresh:(UIRefreshControl*)refreshControl
{
    if([Config instance].isNetworkRunning){
        _isLoadOver = NO;
        [self _reload:NO];
        [refreshControl endRefreshing];
    }
}
- (void)_clear
{
    _allCount = 0;
    [_favorites removeAllObjects];
    _isLoadOver = NO;
}
- (void)_reload:(BOOL)noRefresh
{
    if([Config instance].isNetworkRunning){
        if(_isLoading || _isLoadOver){
            return;
        }
        if(!noRefresh){
            _allCount = 0;
        }
        int pageIndex = _allCount / 20;
        NSString *url = [NSString stringWithFormat:@"%@?uid=%d&type=%d&pageIndex=%d&pageSize=%d", api_favorite_list, [Config instance].getUID,self.catalog, pageIndex, 20];
        [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(!noRefresh){
                [self _clear];
            }
            NSString *response = operation.responseString;
            [Tool getOSCNoticeFromString:response];
            _isLoading = NO;
            @try {
                int count = [Tool isListOverFromString:response];
                if(count < 20){
                    _isLoadOver = YES;
                }
                
                TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
                TBXMLElement *root = xml.rootXMLElement;
                TBXMLElement *favsElt = [TBXML childElementNamed:@"favorites" parentElement:root];
                if(!favsElt){
                    _isLoadOver = YES;
                    [self.tableView reloadData];
                    return;
                }
                TBXMLElement *first = [TBXML childElementNamed:@"favorite" parentElement:favsElt];
                if(!favsElt){
                    _isLoadOver = YES;
                    [self.tableView reloadData];
                    return;
                }
                NSMutableArray *newFavs = [[NSMutableArray alloc] initWithCapacity:20];
                Favorite *fav;
                if(first){
                    fav = [[Favorite alloc] initWithXMLElt:first];
                    if(![Tool isRepeatFavorite:fav inArray:newFavs]){
                        [newFavs addObject:fav];
                    }
                }
                while (first) {
                    first = [TBXML nextSiblingNamed:@"favorite" searchFromElement:first];
                    if(first){
                        fav = [[Favorite alloc] initWithXMLElt:first];
                        if(![Tool isRepeatFavorite:fav inArray:newFavs]){
                            [newFavs addObject:fav];
                        }
                    }else{
                        break;
                    }
                    
                }
                [_favorites addObjectsFromArray:newFavs];
                [self.tableView reloadData];
            }
            @catch (NSException *exception) {
                [UncaughtExceptionHandler takeException:exception];
            }
            @finally {
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取收藏列表失败");
            _isLoading = NO;
            if([Config instance].isNetworkRunning){
                [Tool ToastNotification:@"错误，网络五连接" andView:self.view andLoading:NO andIsBottom:NO];
            }
        }];
        
        _isLoading = YES;
        [self.tableView reloadData];
    }
}
@end
