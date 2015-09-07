//
//  Persion.h
//  core_data
//
//  Created by liujun on 15/9/7.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Persion : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSManagedObject *card;

@end
