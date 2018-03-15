//
//  SJViewControllerAnimatedTransition.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJViewController.h"
@interface SJViewControllerAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic, readonly) UINavigationControllerOperation operation;
@property (weak, nonatomic, readonly) SJViewController *fromViewController;
@property (weak, nonatomic, readonly) SJViewController *toViewController;

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(SJViewController *)fromViewController
                                     toViewController:(SJViewController *)toViewController;
@end
