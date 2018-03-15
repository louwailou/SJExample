//
//  SJViewModelProvider.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewModelProvider.h"
#import <objc/message.h>
#import "SJViewModelServicesProtocol.h"

#pragma mark 依赖注入 获取ViewModel
@implementation SJViewModelProvider
- (instancetype)initWithClass:(id)classObject{
    if (self = [super init]) {
        _classObject = classObject;
    }
    return self;
}

- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments{
    SEL selector = NSSelectorFromString(@"initWithServices:params:");
    if ([_classObject instancesRespondToSelector:selector]) {
        id service = [context getObject:@protocol(SJViewModelServicesProtocol)];
        return ((id (*)(id,SEL,id,id))objc_msgSend)([_classObject alloc],selector,service,arguments.firstObject);
    }
    return nil;
}

@end

@implementation JFItemViewModelProvider
- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments{
    SEL selector = NSSelectorFromString(@"initWithHostViewModel:dataModel:");
    if ([self.classObject instancesRespondToSelector:selector]) {
        return ((id (*)(id,SEL,id,id))objc_msgSend)([self.classObject alloc],selector,arguments.firstObject,arguments.lastObject);
    }
    return nil;
}

@end
