//
//  BCBaseTableCell.m
//  BookingCar
//
//  Created by Michael Shan on 14-10-2.
//  Copyright (c) 2014年 Michael. All rights reserved.
//

#import "BCBaseTableCell.h"

@implementation BCBaseTableCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (id)cell {
    UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:[self identifier] owner:nil options:nil] firstObject];
    [cell setValue:[self identifier] forKey:@"reuseIdentifier"];

    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
