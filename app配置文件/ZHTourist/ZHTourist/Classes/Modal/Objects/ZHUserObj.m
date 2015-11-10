//
//  ZHUserObj.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHUserObj.h"

#define kId             @"id"
#define kPhone          @"phone"
#define kPwd            @"pwd"
#define kToken          @"token"


@implementation ZHUserObj

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.id        forKey:kId];
    [aCoder encodeObject:self.phone     forKey:kPhone];
    [aCoder encodeObject:self.pwd       forKey:kPwd];
    [aCoder encodeObject:self.token     forKey:kToken];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.id = [aDecoder decodeObjectForKey:kId];
        self.phone = [aDecoder decodeObjectForKey:kPhone];
        self.pwd = [aDecoder decodeObjectForKey:kPwd];
        self.token = [aDecoder decodeObjectForKey:kToken];
    }
    
    return self ;
}

- (NSString *)description {
    NSDictionary *dic = [self dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"id", @"phone", @"pwd", @"token", nil]];
    
    return [dic description];
}

@end
