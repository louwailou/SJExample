//
//  SJConfigService.m
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJConfigService.h"

@implementation SJConfigService

+ (void)load{
    [self shared];
}

+ (SJConfigService*)shared{
    static SJConfigService* shareInstance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SJConfigService alloc] init];
    });
    return shareInstance;
}
@end
