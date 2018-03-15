//
//  SJViewController.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJViewModelProtocol.h"
@interface SJViewController : UIViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
@protected
    BOOL _isError;
    NSString *_errorMsg;
}
/**
 *  根据手势滑动百分比设置此transition应该完成还是取消
 */
@property (strong, nonatomic, readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;
/**
 *  用于缓存一张快照
 */
@property (strong, nonatomic) UIView *snapshot;

/**
 *  通过ViewModel初始化

 */
- (instancetype)initWithViewModel:(id<SJViewModelProtocol>)viewModel;

/**
 *  viewModel绑定
 */
- (void)bindViewModel;

/**
 *  左键点击事件
 */
- (void)leftBarItemClicked:(id)sender;



/**
 *  是否启用返回按钮
 */
- (BOOL)enableBackBarButton;

/**
 *  是否使用使用默认导航栏样式
 */
- (BOOL)useOriginalNavigationBarStyle;

/**
 *  是否使用默认错误reload样式

 */
- (BOOL)useDefaultLoadingErrorPage;
@end
