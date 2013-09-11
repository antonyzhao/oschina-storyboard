//
//  LoadingCellSingleton.m
//  osChina
//
//  Created by health on 13-8-28.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "LoadingCellSingleton.h"
#import "LoadingCell.h"

static LoadingCellSingleton *instance;
@implementation LoadingCellSingleton

+ (LoadingCellSingleton*)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LoadingCellSingleton new];
    });
    return instance;
}

- (UITableViewCell*)loadingCellInTableView:(UITableView*)tableView
                             andIsLoadOver:(BOOL)isLoadOver
                            andLoadOverMsg:(NSString*)loadOverMsg
                             andLoadingMsg:(NSString*)loadingMsg
                              andIsLoading:(BOOL)isLoading
{
    LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCelIdentifier"];
    if(cell == nil){
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
        for(id obj in nibs){
            if([obj isKindOfClass:[LoadingCell class]]){
                cell = (LoadingCell*)obj;
                break;
            }
        }
        cell.displayField.text = isLoadOver ? loadOverMsg : loadingMsg;
        if(isLoading){
            cell.loadingField.hidden = NO;
            [cell.loadingField startAnimating];
        }else{
            cell.loadingField.hidden = YES;
            [cell.loadingField stopAnimating];
        }
    }
    return cell;
}
@end
