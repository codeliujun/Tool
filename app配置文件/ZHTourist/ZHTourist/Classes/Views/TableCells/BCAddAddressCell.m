//
//  BCAddAddressCell.m
//  BookingCar
//
//  Created by Michael Shan on 14-10-2.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "BCAddAddressCell.h"


@implementation BCAddAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImgcellImage:(UIImage *)image {
    _imgCellIcon.image = image;
    
    CGRect frame = _imgCellIcon.frame;
    frame.origin.y = (self.height - image.size.height)/2;
    frame.size = image.size;
    _imgCellIcon.frame = frame;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
