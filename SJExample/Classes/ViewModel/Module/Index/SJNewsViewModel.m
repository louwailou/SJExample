//
//  SJNewsViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/15.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJNewsViewModel.h"

@implementation SJNewsViewModel
- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (services) {
        
    }
    return self;
}

- (void)initialize{
    [super initialize];
    self.title = @"新闻";
}
- (void)presetVC{
    [self.services presentTo:Router_Login animated:YES completion:^{
        NSLog(@"present Login callback");
    }];
}
@end
