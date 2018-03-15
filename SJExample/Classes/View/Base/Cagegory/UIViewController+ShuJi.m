//
//  UIViewController+ShuJi.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIViewController+ShuJi.h"
@interface UIViewController (Private)
@property (strong, nonatomic, readwrite) id<SJViewModelProtocol> viewModel;
@end

@implementation UIViewController (ShuJi)

- (id<SJResourceServiceProtocol>)resourceService{
    return [self sj_objection:@protocol(SJResourceServiceProtocol)];
}

- (id<SJRouterServiceProtocol>)routerService{
    return [self sj_objection:@protocol(SJRouterServiceProtocol)];
}
@end
