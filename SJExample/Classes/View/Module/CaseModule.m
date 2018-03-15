//
//  CaseModule.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "CaseModule.h"
#import "SJCaseViewModel.h"
#import "SJCaseViewController.h"
#import "SJCaseViewModelProtocol.h"
#import "SJViewModelProvider.h"

@implementation CaseModule
- (void)configure{
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJCaseViewModel.self] toProtocol:@protocol(SJCaseViewModelProtocol)];
    [self map:Router_Case viewModelProtocol:@protocol(SJCaseViewModelProtocol) toControllerClass:[SJCaseViewController class]];
}
@end
