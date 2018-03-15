//
//  APPModule.m
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "APPModule.h"
#import "SJRouterService.h"
#import "SJViewModelServicesImp.h"
#import "SJViewModelServicesProtocol.h"
#import "SJConfigService.h"
#import "SJConfigServiceProtocol.h"
#import "SJResourceService.h"
#import "SJResourceServiceProtocol.h"
#import "SJViewModelProvider.h"
#import "SJHomeViewModelProtocol.h"
#import "SJHomeViewController.h"
#import "SJHomeViewModel.h"


@implementation JSObjectionModule (ShuJi)

-(void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass{
    [[SJRouterService shared] map:route viewModelProtocol:viewModelProtocol toControllerClass:controllerClass];
}
-(void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope{
    [[SJRouterService shared] map:route viewModelProtocol:viewModelProtocol toControllerClass:controllerClass inScope:scope];
}

@end

@implementation APPModule
-(void)configure{
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [[SJViewModelServicesImp alloc] init];
    } toProtocol:@protocol(SJViewModelServicesProtocol) inScope:JSObjectionScopeSingleton];

    [self bindBlock:^id(JSObjectionInjector *context) {
        return [context getObject:@protocol(SJViewModelServicesProtocol)];
    } toProtocol:@protocol(SJNavigationProtocol) inScope:JSObjectionScopeSingleton];

    /*
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [context getObject:@protocol(SJViewModelServicesProtocol)];
    } toProtocol:@protocol(SJHttpApiDispatcherForRACProtocol) inScope:JSObjectionScopeSingleton];

    [self bindBlock:^id(JSObjectionInjector *context) {
        return [[SJAccountService alloc] initWithDispatcherAndNavService:[context getObject:@protocol(SJHttpApiDispatcherForRACProtocol)]];
    } toProtocol:@protocol(SJAccountServiceProtocol) inScope:JSObjectionScopeSingleton];
*/

    // Router
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [SJRouterService shared];
    } toProtocol:@protocol(SJRouterServiceProtocol) inScope:JSObjectionScopeSingleton];
    
    // config
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [SJConfigService shared];
    } toProtocol:@protocol(SJConfigServiceProtocol) inScope:JSObjectionScopeSingleton];

    // Resource
    [self bind:[SJResourceService shared] toProtocol:@protocol(SJResourceServiceProtocol)];

#ifdef DEBUG
    // [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJDebugConsoleViewModel.self] toProtocol:@protocol(SJDebugConsoleViewModelProtocol)];
    // [self map:Router_DebugConsole viewModelProtocol:@protocol(SJDebugConsoleViewModelProtocol) toControllerClass:[SJDebugConsoleViewController class]];
#endif
    // home tab
    [self bindProvider:[[SJViewModelProvider alloc] initWithClass:SJHomeViewModel.self] toProtocol:@protocol(SJHomeViewModelProtocol)];
    
    [self map:Router_Home viewModelProtocol:@protocol(SJHomeViewModelProtocol) toControllerClass:[SJHomeViewController class] inScope:SJRouterScopeSingleton];
    
  
}
@end


@implementation NSObject(SJObjection)
- (id)sj_objection:(id)classOrProtocol{
    return [[JSObjection defaultInjector] getObject:classOrProtocol];
}

-(id)sj_objection:(id)classOrProtocol argumentList:(NSArray *)argList{
    return [[JSObjection defaultInjector] getObject:classOrProtocol argumentList:argList];
}

-(id)sj_objection:(id)classOrProtocol params:(NSDictionary *)params{
    if (!params) {
        params = @{};
    }
    return [[JSObjection defaultInjector] getObject:classOrProtocol argumentList:@[params]];
}

@end
