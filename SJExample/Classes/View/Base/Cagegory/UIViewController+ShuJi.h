//
//  UIViewController+ShuJi.h
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJRouterServiceProtocol.h"
#import "SJResourceServiceProtocol.h"
#import "SJViewModelProtocol.h"
@interface UIViewController (ShuJi)
@property (strong, readonly, nonatomic) id<SJResourceServiceProtocol> resourceService;
@property (strong, readonly, nonatomic) id<SJRouterServiceProtocol> routerService;
@property (strong, readonly, nonatomic) id<SJViewModelProtocol> viewModel;
@end
