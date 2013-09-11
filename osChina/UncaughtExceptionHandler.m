//
//  UncaughtExceptionHandler.m
//  osChina
//
//  Created by Antony on 13-8-24.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#define ReceiverEmail       @""

@implementation UncaughtExceptionHandler

NSString * applicationDocumentDirectory()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void uncaughtExceptionHandler(NSException *exception){
    NSArray *arr = exception.callStackSymbols;
    
    NSString *reason = exception.reason;
    NSString *name = exception.name;
    NSString *url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString *path = [applicationDocumentDirectory() stringByAppendingPathComponent:@"exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"mailto:%@?subject=开源中国客户端bug报告&body=很抱歉应用出现故障,感谢您的配合!发送这封邮件可协助我们改善此应用<br>"
						"错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",ReceiverEmail,
						name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url2 = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url2];
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}
+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}
+ (void)takeException:(NSException*)exception
{
    NSArray *arr = exception.callStackSymbols;
    NSString *reason = exception.reason;
    NSString *name = exception.name;
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
