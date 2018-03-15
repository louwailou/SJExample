//
//  SJRouterService.m
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJRouterService.h"
#import <objc/message.h>
#import "SJViewModelProtocol.h"
@interface UIViewController (SJRouterService)

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation UIViewController (SJRouterService)

static char kAssociatedParamsObjectKey;

- (void)setParams:(NSDictionary *)paramsDictionary{
    objc_setAssociatedObject(self, &kAssociatedParamsObjectKey, paramsDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params{
    return objc_getAssociatedObject(self, &kAssociatedParamsObjectKey);
}
@end

@interface SJRouterService ()

@property (strong, nonatomic) NSMutableDictionary *routes;
@property (strong, nonatomic) NSMutableDictionary *routeScopes;
@end

@implementation SJRouterService

+ (instancetype)shared{
    static SJRouterService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SJRouterService alloc] init];
    });
    return instance;
}

- (void)map:(NSString *)route toBlock:(SJRouterBlock)block{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = [block copy];
    subRoutes[@"_scope_"] = @(SJRouterScopeNormal);
}

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = controllerClass;
    subRoutes[@"_scope_"] = @(SJRouterScopeNormal);
}

-(void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = controllerClass;
    subRoutes[@"_vm_"] = viewModelProtocol;
    subRoutes[@"_scope_"] = @(SJRouterScopeNormal);
}

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = controllerClass;
    subRoutes[@"_scope_"] = @(scope);
}

- (void)map:(NSString *)route viewModelProtocol:(Protocol *)viewModelProtocol toControllerClass:(Class)controllerClass inScope:(SJRouterScope)scope{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = controllerClass;
    subRoutes[@"_vm_"] = viewModelProtocol;
    subRoutes[@"_scope_"] = @(scope);
}

- (void)map:(NSString *)route toBlock:(SJRouterBlock)block inScope:(SJRouterScope)scope{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    
    subRoutes[@"_"] = [block copy];
    subRoutes[@"_scope_"] = @(scope);
}

- (UIViewController *)matchController:(NSString *)route{
    return [self matchController:route params:nil callback:nil];
}

-(UIViewController *)matchController:(NSString *)route params:(NSDictionary *)param callback:(id)callback{
    UIViewController *viewController = nil;
    
    NSDictionary *routParams = [self paramsInRoute:route];
    /*
     {
     "controller_class" = JFProductLikeWuKongViewController;
     "controller_protocol" = "<Protocol: 0x104d156f8>";
     "controller_scope" = 0;
     route = "jfwallet://JFProductLikeWuKongViewModelProtocol";
     }
     */
    BOOL needCache = [routParams[@"controller_scope"] isEqualToNumber:@(SJRouterScopeSingleton)];
    Class controllerClass = routParams[@"controller_class"];
    Protocol *protocol = routParams[@"controller_protocol"];
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:param];
    [paramDic addEntriesFromDictionary:routParams];
    
    NSString *cacheKey = NSStringFromClass(controllerClass);
    if (needCache && self.routeScopes[cacheKey]) {
        viewController = self.routeScopes[cacheKey];
        id<SJViewModelProtocol> vm = [viewController valueForKey:@"viewModel"];
        vm.params = paramDic;
    }else{
        /******************************************************/
        if (protocol) {
            SEL selector = NSSelectorFromString(@"initWithViewModel:");
            if ([controllerClass instancesRespondToSelector:selector]) {
                id<SJViewModelProtocol> vm = [self sj_objection:protocol params:paramDic];
                vm.callbackCommand = callback;
                
                viewController = ((id (*)(id,SEL,id))objc_msgSend)([controllerClass alloc],selector,vm);
            }else{
                viewController = [[controllerClass alloc] init];
            }
        }else{
            viewController = [[controllerClass alloc] init];
        }
        
        
        
        if ([viewController respondsToSelector:@selector(setParams:)]) {
            [viewController performSelector:@selector(setParams:)
                                 withObject:[paramDic copy]];
        }
        
        if (needCache) {
            self.routeScopes[cacheKey] = viewController;
        }
    }
    return viewController;
}

- (UIViewController *)match:(NSString *)route{
    return [self matchController:route];
}

- (SJRouterBlock)matchBlock:(NSString *)route{
    NSDictionary *params = [self paramsInRoute:route];
    
    if (!params){
        return nil;
    }
    
    SJRouterBlock routerBlock = [params[@"block"] copy];
    SJRouterBlock returnBlock = ^id(Class cls,Protocol *protocol,NSDictionary *aParams) {
        if (routerBlock) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
            [dic addEntriesFromDictionary:aParams];
            return routerBlock(cls,protocol,[NSDictionary dictionaryWithDictionary:dic].copy);
        }
        return nil;
    };
    
    return [returnBlock copy];
}

- (id)callBlock:(NSString *)route{
    NSDictionary *params = [self paramsInRoute:route];
    SJRouterBlock routerBlock = [params[@"block"] copy];
    
    Class controllerClass = params[@"controller_class"];
    Protocol *protocol = params[@"controller_protocol"];
    if (routerBlock) {
        return routerBlock(controllerClass,protocol,[params copy]);
    }
    return nil;
}

- (NSDictionary *)paramsInRoute:(NSString *)route{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"route"] = [self stringFromFilterAppUrlScheme:route];
    
    NSMutableDictionary *subRoutes = self.routes;
    NSArray *pathComponents = [self pathComponentsFromRoute:params[@"route"]];
    for (NSString *pathComponent in pathComponents) {
        BOOL found = NO;
        NSArray *subRoutesKeys = subRoutes.allKeys;
        for (NSString *key in subRoutesKeys) {
            if ([subRoutesKeys containsObject:pathComponent]) {
                found = YES;
                subRoutes = subRoutes[pathComponent];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                params[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        if (!found) {
            return nil;
        }
    }
    
    NSRange firstRange = [route rangeOfString:@"?"];
    if (firstRange.location != NSNotFound && route.length > firstRange.location + firstRange.length) {
        NSString *paramsString = [route substringFromIndex:firstRange.location + firstRange.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramStringArr) {
            NSArray *paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString *key = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                params[key] = value;
            }
        }
    }
    
    Class class = subRoutes[@"_"];
    if (class_isMetaClass(object_getClass(class))) {
        if ([class isSubclassOfClass:[UIViewController class]]) {
            params[@"controller_class"] = subRoutes[@"_"];
            if (subRoutes[@"_vm_"]) {
                params[@"controller_protocol"] = subRoutes[@"_vm_"];
            }
        } else {
            return nil;
        }
    } else {
        if (subRoutes[@"_"]) {
            params[@"block"] = [subRoutes[@"_"] copy];
        }
    }
    
    params[@"controller_scope"] = subRoutes[@"_scope_"];
    
    /*
     params {
     "controller_class" = JFProductLikeWuKongViewController;
     "controller_protocol" = "<Protocol: 0x104d156f8>";
     "controller_scope" = 0;
     route = "jfwallet://JFProductLikeWuKongViewModelProtocol";
     }
     */
    return [NSDictionary dictionaryWithDictionary:params];
}

#pragma mark - Private

- (NSMutableDictionary *)routes{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    
    return _routes;
}

-(NSMutableDictionary *)routeScopes{
    if (!_routeScopes) {
        _routeScopes = [[NSMutableDictionary alloc] init];
    }
    
    return _routeScopes;
}

- (NSArray *)pathComponentsFromRoute:(NSString *)route{
    NSMutableArray *pathComponents = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:[route stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSString *pathComponent in url.path.pathComponents) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:[pathComponent stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (!pathComponents.count) {
        [pathComponents addObject:[url.host stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return [pathComponents copy];
}

- (NSString *)stringFromFilterAppUrlScheme:(NSString *)string{
    for (NSString *appUrlScheme in [self appUrlSchemes]) {
        if ([string hasPrefix:[NSString stringWithFormat:@"%@:", appUrlScheme]]) {
            return [string substringFromIndex:appUrlScheme.length + 2];
        }
    }
    
    return string;
}

- (NSArray *)appUrlSchemes{
    NSMutableArray *appUrlSchemes = [NSMutableArray array];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    for (NSDictionary *dic in infoDictionary[@"CFBundleURLTypes"]) {
        NSString *appUrlScheme = dic[@"CFBundleURLSchemes"][0];
        [appUrlSchemes addObject:appUrlScheme];
    }
    
    return [appUrlSchemes copy];
}

- (NSMutableDictionary *)subRoutesToRoute:(NSString *)route{
    NSArray *pathComponents = [self pathComponentsFromRoute:route];
    
    NSInteger index = 0;
    NSMutableDictionary *subRoutes = self.routes;
    
    while (index < pathComponents.count) {
        NSString *pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    
    return subRoutes;
}

- (SJRouteType)canRoute:(NSString *)route{
    NSDictionary *params = [self paramsInRoute:route];
    
    if (params[@"controller_class"]) {
        return SJRouteTypeViewController;
    }
    
    if (params[@"block"]) {
        return SJRouteTypeBlock;
    }
    
    return SJRouteTypeNone;
}

@end
