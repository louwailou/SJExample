//
//  SJViewModelServicesProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//
#import "SJAccountServiceProtocol.h"
#import "SJNavigationProtocol.h"
#import "SJResourceServiceProtocol.h"
#import "SJConfigServiceProtocol.h"
@protocol SJViewModelServicesProtocol <SJNavigationProtocol>

/**
 *  账户服务，用于对当前账户的操作
 */
@property (strong, nonatomic, readonly) id<SJAccountServiceProtocol> accountService;

/**
 *  资源服务
 */
@property (strong, nonatomic, readonly) id<SJResourceServiceProtocol> resourceService;

/**
 *  配置服务
 */
@property(strong, nonatomic, readonly)id<SJConfigServiceProtocol> configService;


@end
