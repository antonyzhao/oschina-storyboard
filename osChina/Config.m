//
//  Config.m
//  osChina
//
//  Created by health on 13-8-23.
//  Copyright (c) 2013年 osChina. All rights reserved.
//

#import "Config.h"
#import "AESCrypt.h"

static Config *instance;
@implementation Config

+ (Config*)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Config new];
    });
    return instance;
}

- (void)saveUsername:(NSString*)username andPassword:(NSString*)password
{
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults removeObjectForKey:@"password"];
    
    [userDefaults setObject:username forKey:@"username"];
    
    NSString *encrypePwd = [AESCrypt encrypt:password password:kEncryptKey];
    [userDefaults setObject:encrypePwd forKey:@"password"];
    
    [userDefaults synchronize];
}
- (NSString*)getIOSGuid
{
    NSString *value = [userDefaults objectForKey:@"guid"];
    if(value && [value isEqualToString:@""] == NO){
        return value;
    }else{
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault,uuid);
        CFRelease(uuid);
        [userDefaults setObject:uuidString forKey:@"guid"];
        [userDefaults synchronize];
        return uuidString;
    }
    return @"";
}
- (void)saveCookie:(BOOL)cookie
{
    [userDefaults removeObjectForKey:@"cookie"];
    [userDefaults setObject:cookie ? @"1" : @"0" forKey:@"cookie"];
    [userDefaults synchronize];
}
-(BOOL)isCookie
{
    NSString *value = [userDefaults objectForKey:@"cookie"];
    if(value && [value isEqualToString:@"1"]){
        return YES;
    }
    return NO;
}
-(void)saveUID:(int)uid
{
    [userDefaults removeObjectForKey:@"UID"];
    [userDefaults setObject:[NSString stringWithFormat:@"%i",uid] forKey:@"UID"];
    [userDefaults synchronize];
}
-(int)getUID
{
    NSString *value = [userDefaults objectForKey:@"UID"];
    if(value && [value isEqualToString:@""] == NO){
        return [value intValue];
    }
    return 0;
}

- (NSString*)getUsername
{
    return [userDefaults objectForKey:@"username"];
}
- (NSString*)getPassword
{
    NSString *temp = [userDefaults objectForKey:@"password"];
    return [AESCrypt decrypt:temp password:kEncryptKey];
}


@end
