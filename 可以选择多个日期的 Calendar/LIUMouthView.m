//
//  LIUMouthView.m
//  LIUCalendar
//
//  Created by liujun on 15/7/12.
//  Copyright (c) 2015年 liujun. All rights reserved.
//

#define  kSpace             30
#define  kScreenBounds      [UIScreen mainScreen].bounds

#import "LIUMouthView.h"

@interface LIUMouthView ()

@property(nonatomic,strong)UIButton *previousButton;
@property(nonatomic,strong)UIButton *nextButton;

@end

@implementation LIUMouthView

- (instancetype)init {
    if (self = [super init]) {
        [self layoutSubLabels];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self layoutSubLabels];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutSubLabels];
    }
    return self;
}

- (void)layoutSubLabels {
    
    self.previousButton = [[UIButton alloc]initWithFrame:CGRectMake(kSpace, 5, 60, self.bounds.size.height-10)];
    self.previousButton.backgroundColor = [UIColor orangeColor];
    self.previousButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.previousButton.layer.cornerRadius = 5;
    self.previousButton.layer.masksToBounds = YES;
    //[self.previousButton setTitle:@"上一月" forState:UIControlStateNormal];
    [self.previousButton addTarget:self action:@selector(loadPreviousMouth:) forControlEvents:UIControlEventTouchUpInside];
    self.previousButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.previousButton];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.previousButton.frame), CGRectGetMidY(self.previousButton.frame));
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(center.x-10, center.y-10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"减"];
    [self addSubview:imageView];
    
    
    self.nextButton = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-kSpace-60, 5, 60, self.bounds.size.height-10)];
    self.nextButton.backgroundColor = [UIColor orangeColor];
    self.nextButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.nextButton.layer.cornerRadius = 5;
    self.nextButton.layer.masksToBounds = YES;
    [self.nextButton addTarget:self action:@selector(loadNextMouth:) forControlEvents:UIControlEventTouchUpInside];
    //[self.nextButton setTitle:@"下一月" forState:UIControlStateNormal];
    self.nextButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.nextButton];
    
    center = CGPointMake(CGRectGetMidX(self.nextButton.frame), CGRectGetMidY(self.nextButton.frame));
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(center.x-10, center.y-10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"加"];
    [self addSubview:imageView];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, self.bounds.size.height)];
    self.dateLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    self.dateLabel.text = @"00000";
    [self addSubview:self.dateLabel];
    
}

- (void)loadPreviousMouth:(UIButton *)sender {
    [self.delegate didTapPreviousButton];
}

- (void)loadNextMouth:(UIButton *)sender {
    [self.delegate didTapNextButton];
}


@end
