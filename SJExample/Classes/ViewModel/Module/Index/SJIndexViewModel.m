//
//  SJIndexViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJIndexViewModel.h"

@implementation SJIndexViewModel

- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (services) {
        
    }
    return self;
}

- (void)initialize{
    [super initialize];
    self.title = @"首页";
}
- (void)presetVC{
    [self.services pushTo:Router_News animated:YES];
}
@end
