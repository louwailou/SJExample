//
//  SJHomeViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/13.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJHomeViewModel.h"
@interface SJHomeViewModel()
@property (copy, nonatomic, readwrite) NSString *indexRoute;

@property (copy, nonatomic, readwrite) NSString *workRoute;

@property (copy, nonatomic, readwrite) NSString *caseRoute;

@property (copy, nonatomic, readwrite) NSString *myRoute;

@property (assign, nonatomic,readwrite) NSInteger selectedIndex;
@end
@implementation SJHomeViewModel

-(instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params{
    if (self = [super initWithServices:services params:params]) {
       self.selectedIndex = [params[@"selectedIndex"] integerValue];
    }
    return self;
}


- (void)initialize {
    [super initialize];
    self.title = @"";
    self.indexRoute = Router_Index;
    self.caseRoute = Router_Case;
    self.myRoute = Router_Profile;
    self.workRoute = Router_Work;
    
    
}
- (void)tabbarDidSelectedIndex:(NSInteger)index{
    [self.services changeTabbarWithIndex:index];
}
@end
