//
//  BCAddAddressCell.h
//  BookingCar
//
//  Created by Michael Shan on 14-10-2.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "BCBaseTableCell.h"

@interface BCAddAddressCell : BCBaseTableCell
@property (weak, nonatomic) IBOutlet UIImageView *imgCellIcon;
@property (weak, nonatomic) IBOutlet UITextField *tfInputField;
@property (weak, nonatomic) IBOutlet UIView *cutOffRule;//cell的分割线

- (void)setImgcellImage:(UIImage *)image;

@end
