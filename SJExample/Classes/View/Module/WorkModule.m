//
//  WorkModule.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "WorkModule.h"
#import "SJWorkViewModel.h"
#import "SJWorkViewController.h"
#import "SJWorkViewModelProtocol.h"
#import "SJViewModelProvider.h"
@implementation WorkModule
- (void)configure{
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJWorkViewModel.self] toProtocol:@protocol(SJWorkViewModelProtocol)];
    [self map:Router_Work viewModelProtocol:@protocol(SJWorkViewModelProtocol) toControllerClass:[SJWorkViewController class]];
}
@end
