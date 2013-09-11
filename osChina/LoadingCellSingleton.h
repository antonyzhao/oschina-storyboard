//
//  LoadingCellSingleton.h
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingCellSingleton : NSObject

+ (LoadingCellSingleton*)instance;

- (UITableViewCell*)loadingCellInTableView:(UITableView*)tableView
                             andIsLoadOver:(BOOL)isLoadOver
                            andLoadOverMsg:(NSString*)loadOverMsg
                             andLoadingMsg:(NSString*)loadingMsg
                              andIsLoading:(BOOL)isLoading;
@end
