//
//  ZHUtility.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHUtility.h"

@implementation ZHUtility

+ (void)saveValue:(id)value withKey:(NSString *)key {
    DBLog(@"set\n(key,value):(%@,%@)",key,value);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (id)getValueWithKey:(NSString *)key {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return value;
}

+ (void)saveSetting:(id)value withKey:(NSString *)key {
    [self saveValue:value withKey:key];
}

+ (id)restoreSetting:(NSString *)key{
    return [self getValueWithKey:key];
}

+ (AppDelegate *)appDelegate{
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate = (AppDelegate *)[application delegate];
    return appDelegate;
}

+ (UIWindow *)appKeyWindow {
    return [[self appDelegate] window];
}


@end
