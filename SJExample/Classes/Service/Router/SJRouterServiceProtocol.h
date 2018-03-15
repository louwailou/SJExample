//
//  SJRouterServiceProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//


typedef NS_ENUM (NSInteger, SJRouteType) {
    SJRouteTypeNone = 0,
    SJRouteTypeViewController = 1,
    SJRouteTypeBlock = 2
};

typedef NS_ENUM (NSInteger, SJRouterScope)  {
    SJRouterScopeNormal,
    SJRouterScopeSingleton
};

typedef id (^SJRouterBlock)(Class cls, Protocol *viewModelProtocol, NSDictionary *params);


@protocol SJRouterServiceProtocol<NSObject>
- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route toBlock:(SJRouterBlock)block;

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope;
- (void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope;
- (void)map:(NSString *)route toBlock:(SJRouterBlock)block inScope:(SJRouterScope)scope;

- (UIViewController *)matchController:(NSString *)route;

- (UIViewController *)matchController:(NSString *)route params:(NSDictionary *)params callback:(id)callback;

@end
