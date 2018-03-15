//
//  IndexModule.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "IndexModule.h"
#import "SJIndexViewModel.h"
#import "SJIndexViewController.h"
#import "SJIndexViewModelProtocol.h"
#import "SJViewModelProvider.h"

//

#import "SJNewsViewModel.h"
#import "SJNewsViewController.h"
#import "SJNewsViewModelProtocol.h"
@implementation IndexModule
- (void)configure{
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJIndexViewModel.self] toProtocol:@protocol(SJIndexViewModelProtocol)];
    [self map:Router_Index viewModelProtocol:@protocol(SJIndexViewModelProtocol) toControllerClass:[SJIndexViewController class]];
    
    //新闻
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJNewsViewModel.self] toProtocol:@protocol(SJNewsViewModelProtocol)];
    [self map:Router_News viewModelProtocol:@protocol(SJNewsViewModelProtocol) toControllerClass:[SJNewsViewController class]];
}
@end
