//
//  BCBaseTableCell.h
//  BookingCar
//
//  Created by Michael Shan on 14-10-2.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCBaseTableCell : UITableViewCell

+ (NSString *)identifier;
+ (id)cell;

- (void)updateCellContent:(id)obj;

@end
