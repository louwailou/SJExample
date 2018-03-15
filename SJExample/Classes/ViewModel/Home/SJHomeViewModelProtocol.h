//
//  SJHomeViewModelProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/13.
//  Copyright © 2018年 Sun. All rights reserved.
//
#import "SJViewModelProtocol.h"
@protocol SJHomeViewModelProtocol <SJViewModelProtocol>

@property (copy, nonatomic, readonly) NSString *indexRoute;

@property (copy, nonatomic, readonly) NSString *workRoute;

@property (copy, nonatomic, readonly) NSString *caseRoute;

@property (copy, nonatomic, readonly) NSString *myRoute;

@property (assign, nonatomic,readonly) NSInteger selectedIndex;

- (void)tabbarDidSelectedIndex:(NSInteger)index;

@end
