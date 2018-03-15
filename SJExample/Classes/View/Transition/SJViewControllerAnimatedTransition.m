//
//  SJViewControllerAnimatedTransition.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewControllerAnimatedTransition.h"
@interface SJViewControllerAnimatedTransition ()

@property (assign, nonatomic, readwrite) UINavigationControllerOperation operation;
@property (weak, nonatomic, readwrite) SJViewController *fromViewController;
@property (weak, nonatomic, readwrite) SJViewController *toViewController;

@end

@implementation SJViewControllerAnimatedTransition
- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(SJViewController *)fromViewController
                                     toViewController:(SJViewController *)toViewController {
    self = [super init];
    if (self) {
        self.operation = operation;
        self.fromViewController = fromViewController;
        self.toViewController = toViewController;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    SJViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SJViewController *toVC  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.operation == UINavigationControllerOperationPush) { // push
        [[transitionContext containerView] addSubview:fromVC.snapshot];
        fromVC.view.hidden = YES;
        
        CGRect frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
        [[transitionContext containerView] addSubview:toVC.view];
        
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromVC.snapshot.alpha = 0.0;
                             fromVC.snapshot.frame = CGRectInset(fromVC.view.frame, 20, 20);
                             toVC.view.frame = CGRectOffset(toVC.view.frame, -CGRectGetWidth(toVC.view.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             fromVC.view.hidden = NO;
                             [fromVC.snapshot removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    } else if (self.operation == UINavigationControllerOperationPop) { // pop
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
        
        [fromVC.view addSubview:fromVC.snapshot];
        fromVC.navigationController.navigationBar.hidden = YES;
        
        toVC.view.hidden = YES;
        toVC.snapshot.alpha = 0.5;
        toVC.snapshot.transform = CGAffineTransformMakeScale(0.95, 0.95);
        
        [[transitionContext containerView] addSubview:toVC.view];
        [[transitionContext containerView] addSubview:toVC.snapshot];
        [[transitionContext containerView] sendSubviewToBack:toVC.snapshot];
        
        fromVC.view.frame = CGRectMake(0, CGRectGetMinY(fromVC.view.frame), CGRectGetWidth(fromVC.view.frame), CGRectGetHeight(fromVC.view.frame));
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromVC.view.frame = CGRectOffset(fromVC.view.frame, CGRectGetWidth(fromVC.view.frame), 0);
                             toVC.snapshot.alpha = 1.0;
                             toVC.snapshot.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
                             
                             toVC.navigationController.navigationBar.hidden = NO;
                             toVC.view.hidden = NO;
                             
                             [fromVC.snapshot removeFromSuperview];
                             [toVC.snapshot removeFromSuperview];
                             
                             // Reset toViewController's `snapshot` to nil
                             if (![transitionContext transitionWasCancelled]) {
                                 toVC.snapshot = nil;
                             }
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
