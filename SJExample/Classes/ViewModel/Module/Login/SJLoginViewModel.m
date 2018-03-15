//
//  SJLoginViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJLoginViewModel.h"

@implementation SJLoginViewModel
- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params{
    self = [super initWithServices:services params:params];
    if (services) {
        
    }
    return self;
}

- (void)initialize{
    [super initialize];
    self.title = @"登录";
    
}
- (SJCallback)backCommand{
    __weak typeof(self) weakSelf = self;
    SJCallback back = ^(NSDictionary *params, NSError*error){
        [weakSelf.services dismiss:YES completion:nil];
    };
    return back;
}
- (void)push {
     [self.services pushTo:Router_News animated:YES];
}
@end
