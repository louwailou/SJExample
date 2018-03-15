//
//  SJViewModelServiceImp.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewModelServicesImp.h"
#import "SJViewController.h"
#import "SJViewControllerAnimatedTransition.h"
#import "SJTabbarViewController.h"

@interface SJViewModelServicesImp ()<UINavigationControllerDelegate>
@property (strong,nonatomic) id<SJRouterServiceProtocol> routerService;
@property (strong,nonatomic) NSMutableArray<UINavigationController *> *navigationControllers;
@property (weak,nonatomic) UITabBarController *tabbarController;

@end

@implementation SJViewModelServicesImp
//@synthesize navigationStack = _navigationStack;
@synthesize accountService = _accountService;
@synthesize resourceService = _resourceService;
@synthesize configService = _configService;

- (instancetype)init {
    self = [super init];
    if (self) {
       // _dispatcherTable = [NSMutableDictionary dictionaryWithCapacity:5];
       // [KTAPIServiceChannelFactory setServiceChannelCommonDelegate:self];
        
      self.navigationControllers = [[NSMutableArray alloc] init];
      
    }
    return self;
}

#pragma mark 删除
//-(instancetype)initWithNavigationStack:(SJNavigationControllerStack *)navigationStack{
//    if (self = [self init]) {
//       // _navigationStack = navigationStack;
//       // [_navigationStack setServices:self];
//    }
//    return self;
//}

-(id<SJAccountServiceProtocol>)accountService{
    if (!_accountService) {
        _accountService = [self sj_objection:@protocol(SJAccountServiceProtocol)];
    }
    return _accountService;
}

-(id<SJResourceServiceProtocol>)resourceService{
    if (!_resourceService) {
        _resourceService = [self sj_objection:@protocol(SJResourceServiceProtocol)];
    }
    return _resourceService;
}

-(id<SJConfigServiceProtocol>)configService{
    if (!_configService) {
        _configService = [self sj_objection:@protocol(SJConfigServiceProtocol)];
    }
    return _configService;
}

-(id<SJRouterServiceProtocol>)routerService{
    if (!_routerService) {
        _routerService = [self sj_objection:@protocol(SJRouterServiceProtocol)];
    }
    return _routerService;
}

/**
 *  push 到新的页面VC
 */
- (void)pushTo:(NSString *)route animated:(BOOL)animated{
    [self pushTo:route params:nil callbackCommand:nil animated:animated];
}

- (void)pushTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback)callbackCommand animated:(BOOL)animated{
#pragma mark 注意
    
    if(!self.topNavigationController){
        UINavigationController *nav = self.tabbarController.selectedViewController;
        [self pushNavigationController:nav];
    }
    SJViewController *topViewController = (SJViewController *)[self.topNavigationController topViewController];
    if (topViewController.snapshot == nil) {
        topViewController.snapshot = [[self.topNavigationController view] snapshotViewAfterScreenUpdates:NO];
    }
    if ([[route lowercaseString] hasPrefix:@"sjfupin"]){
        
        UIViewController *viewController = [self.routerService matchController:route params:params callback:callbackCommand];
        viewController.hidesBottomBarWhenPushed = YES;
       
        //防止打开同一个vc时候崩溃
        //防止打开home时又打开home
        if ([self.topNavigationController.topViewController isEqual:viewController] || [viewController.childViewControllers containsObject:self.tabbarController]) {
            return;
        }
        [self.topNavigationController pushViewController:viewController animated:animated];
    }else if([[route lowercaseString] hasPrefix:@"http"]) {
        
       // [self.services pushTo:Router_Web params:@{@"startPageUrl":[tuple.first mj_url].description} callbackCommand:tuple.third animated:[tuple.last boolValue]];
    }
}

/**
 *  pop之前的页面VC
 */
- (void)pop:(BOOL)animated{
    [self popTo:nil animated:animated];
}

/**
 *  pop到指定VC
 */
- (void)popTo:(NSString *)route animated:(BOOL)animated{
    if (route && route.length >0) {
        UIViewController *vc = nil;
        
        for (UIViewController *itemVC in self.topNavigationController.viewControllers) {
            NSDictionary *params = [itemVC valueForKey:@"params"];
            NSString *rout = params[@"route"];
            if (rout && [rout containsString:route]) {
                vc = itemVC;
                break;
            }
        }
      
        [self.topNavigationController popToViewController:vc animated:animated];
    }else{
        
        [self.topNavigationController popViewControllerAnimated:animated];
    }
}

/**
 *  返回到根控制器VC

 */
- (void)popToRoot:(BOOL)animated{
     [self.topNavigationController popToRootViewControllerAnimated:animated];
}

/**
 *  能否pop到指定VC
 */
- (BOOL)canPopTo:(NSString *)route{
    return YES;
}


- (void)changeTabbarWithIndex:(NSInteger)index{
     [self changeTabbarControllerSelectIndex:index needPopLastVC:YES];
}

#pragma mark present VC

- (void)presentTo:(NSString *)route animated:(BOOL)animated completion:(void (^)(void))completion{
    [self presentTo:route params:nil callbackCommand:nil animated:animated completion:completion];
}

- (void)presentTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback)callbackCommand animated:(BOOL)animated completion:(void (^)(void))completion{
    [self presentTo:route params:params callbackCommand:callbackCommand animated:animated clearback:NO completion:completion];
}

- (void)presentTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback)callbackCommand animated:(BOOL)animated clearback:(BOOL)clear completion:(void (^)(void))completion{
    UIViewController *viewController = [self.routerService matchController:route params:params callback:callbackCommand];
#pragma mark 需要注意
    if(!self.topNavigationController){
        UINavigationController *nav = self.tabbarController.selectedViewController;
        [self pushNavigationController:nav];
    }
    
    if (![viewController isKindOfClass:UINavigationController.class]) {
        viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        if (clear) {
            viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        }
    }
    UINavigationController *presentingViewController = self.topNavigationController;
    [self pushNavigationController:(UINavigationController *)viewController];
    [presentingViewController presentViewController:viewController animated:animated completion:completion];
}


/**
 *  关闭一个模态视图VC
 */
- (void)dismiss:(BOOL)animated completion:(void (^)(void))completion{
    [self.topNavigationController dismissViewControllerAnimated:animated completion:completion];
    [self popNavigationController];
}

/**
 *  重新设置keywindow的根控制器VC
 */
- (void)resetRootTo:(NSString *)route animated:(BOOL)animated{
    [self resetRootTo:route params:nil animated:animated];
}

- (void)resetRootTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated{
    [self.navigationControllers removeAllObjects];
    
    UIViewController *viewController = [self.routerService matchController:route params:params callback:nil];
    UIViewController *navController = nil;
    
    if (![viewController isKindOfClass:[UINavigationController class]]
        && ![viewController isKindOfClass:[SJTabbarViewController class]]) {
        
        UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:viewController];
        vc.delegate = self;
        
        [self pushNavigationController:vc];
        navController = vc;
        
    }else{
        if ([viewController isKindOfClass:[SJTabbarViewController class]]) {
            SJTabbarViewController *tabVC = (SJTabbarViewController *)viewController;
            [self setTabbarController:tabVC.tabBarController];
            
        }
        navController = viewController;
    }
    
    if (animated) {
        UIView *oldView = [[UIApplication sharedApplication].delegate.window.rootViewController.view snapshotViewAfterScreenUpdates:NO];
        [navController.view addSubview:oldView];
        
        [UIApplication sharedApplication].delegate.window.rootViewController = navController;
        
        [UIView animateWithDuration:1.0f delay:.0f usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
            oldView.transform = CGAffineTransformScale(oldView.transform, 1.5, 1.5);
            oldView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [oldView removeFromSuperview];
        }];
    }else{
        [UIApplication sharedApplication].delegate.window.rootViewController = navController;
    }
}


- (void)changeTabbarControllerSelectIndex:(NSInteger)index needPopLastVC:(BOOL)needPop{
    [self popNavigationController];
    if (needPop) {
        UINavigationController *nav = self.tabbarController.selectedViewController;
        [nav popToRootViewControllerAnimated:NO];//先pop到根
    }
    
    UINavigationController *newNav = self.tabbarController.viewControllers[index];
    [newNav popToRootViewControllerAnimated:NO];
    if (![self.tabbarController.selectedViewController isEqual:newNav]) {
        self.tabbarController.selectedViewController = newNav;
    }
    [self pushNavigationController:newNav];
}


- (void)pushNavigationController:(UINavigationController *)navigationController {
    @synchronized (self) {
        if ([self.navigationControllers containsObject:navigationController]) return;
        [self.navigationControllers addObject:navigationController];
        navigationController.delegate = self;
    }
}

- (UINavigationController *)popNavigationController {
    @synchronized (self) {
        UINavigationController *navigationController = self.navigationControllers.lastObject;
        [self.navigationControllers removeLastObject];
        return navigationController;
    }
}

- (UINavigationController *)topNavigationController {
    @synchronized (self) {
        return self.navigationControllers.lastObject;
    }
}



#pragma mark 网络请求添加
#pragma warning !!!!网络请求添加






#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(SJViewControllerAnimatedTransition *)animationController {
    return animationController.fromViewController.interactivePopTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(SJViewController *)fromVC
                                                 toViewController:(SJViewController *)toVC {
    if (fromVC.interactivePopTransition != nil) {
        return [[SJViewControllerAnimatedTransition alloc] initWithNavigationControllerOperation:operation
                                                                              fromViewController:fromVC
                                                                                toViewController:toVC];
    }
    return nil;
}



-(BOOL)jf_canPopTo:(NSString *)toRoute{
   
    for (UIViewController *itemVC in self.topNavigationController.viewControllers) {
        NSDictionary *params = [itemVC valueForKey:@"params"];
        NSString *route = params[@"route"];
        if (route && [route containsString:toRoute]) {
            return YES;
        }
    }
    
    return NO;
}

@end
