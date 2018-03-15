//
//  JFNavigationProtocol.h
//  JiuFuWallet
//
//  Created by jayden on 15/1/10.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "SJViewModelProtocol.h"

@protocol SJNavigationProtocol <NSObject>

/**
 *  push 到新的页面VC
 */
- (void)pushTo:(NSString *)route animated:(BOOL)animated;

- (void)pushTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback )callbackCommand animated:(BOOL)animated;

/**
 *  pop之前的页面VC
 *

 */
- (void)pop:(BOOL)animated;

/**
 *  pop到指定VC
 */
- (void)popTo:(NSString *)route animated:(BOOL)animated;

/**
 *  能否pop到指定VC
 */
- (BOOL)canPopTo:(NSString *)route;

/**
 *  返回到根控制器VC
 *
 */
- (void)popToRoot:(BOOL)animated;

/**
 * 切换tabbar页面
 **/
- (void)changeTabbarWithIndex:(NSInteger)index;

/**
 *  展示从下到上pop一个视图（模态）VC
 */
- (void)presentTo:(NSString *)route animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)presentTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback)callbackCommand animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)presentTo:(NSString *)route params:(NSDictionary *)params callbackCommand:(SJCallback)callbackCommand animated:(BOOL)animated clearback:(BOOL)clear completion:(void (^)(void))completion;


/**
 *  关闭一个模态视图VC
 */
- (void)dismiss:(BOOL)animated completion:(void (^)(void))completion;

/**
 *  重新设置keywindow的根控制器VC
 
 */
- (void)resetRootTo:(NSString *)route animated:(BOOL)animated;
- (void)resetRootTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated;

@end
