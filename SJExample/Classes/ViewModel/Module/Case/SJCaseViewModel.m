//
//  SJProfileViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJCaseViewModel.h"

@implementation SJCaseViewModel

- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (services) {
        
    }
    return self;
}

- (void)initialize{
    [super initialize];
     self.title = @"扶贫案例";
}

@end
