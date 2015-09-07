//
//  AppDelegate.h
//  core_data
//
//  Created by liujun on 15/9/7.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic,strong,readonly)NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong,readonly)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong,readonly)NSManagedObjectModel *managedObjectModel;//数据模型

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

