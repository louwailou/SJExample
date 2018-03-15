//
//  SJRouterService.h
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJRouterServiceProtocol.h"
@interface SJRouterService : NSObject<SJRouterServiceProtocol>
+ (instancetype)shared;
- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route toBlock:(SJRouterBlock)block;

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope;
- (void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope;
- (void)map:(NSString *)route toBlock:(SJRouterBlock)block inScope:(SJRouterScope)scope;

- (UIViewController *)matchController:(NSString *)route;

- (UIViewController *)matchController:(NSString *)route params:(NSDictionary *)params callback:(id)callback;

- (SJRouterBlock)matchBlock:(NSString *)route;

- (id)callBlock:(NSString *)route;

- (SJRouteType)canRoute:(NSString *)route;
@end
