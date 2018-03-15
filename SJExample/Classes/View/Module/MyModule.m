//
//  MyModule.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "MyModule.h"
#import "SJProfileViewModel.h"
#import "SJProfileViewController.h"
#import "SJProfileViewModelProtocol.h"
#import "SJViewModelProvider.h"

@implementation MyModule

- (void)configure{
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJProfileViewModel.self] toProtocol:@protocol(SJProfileViewModelProtocol)];
    [self map:Router_Profile viewModelProtocol:@protocol(SJProfileViewModelProtocol) toControllerClass:[SJProfileViewController class]];
}

@end
