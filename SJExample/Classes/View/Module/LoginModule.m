//
//  LoginModule.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "LoginModule.h"
#import "SJLoginViewModel.h"
#import "SJLoginViewController.h"
#import "SJLoginViewModelProtocol.h"
#import "SJViewModelProvider.h"
@implementation LoginModule
- (void)configure{
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJLoginViewModel.self] toProtocol:@protocol(SJLoginViewModelProtocol)];
    [self map:Router_Login viewModelProtocol:@protocol(SJLoginViewModelProtocol) toControllerClass:[SJLoginViewController class]];
}
@end
