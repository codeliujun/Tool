//
//  Card.h
//  core_data
//
//  Created by liujun on 15/9/7.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Persion;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSNumber * no;
@property (nonatomic, retain) Persion *persion;

@end
