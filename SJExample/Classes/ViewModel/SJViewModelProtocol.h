//
//  SJViewModelProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//
@protocol SJViewModelServicesProtocol, SJNavigationProtocol;

@protocol SJViewModelProtocol <NSObject>

@property (strong, nonatomic,  readonly) id<SJViewModelServicesProtocol> services;
/**
 *  导航服务 (vc可能会用到)
 */
@property (weak,nonatomic, readonly) id<SJNavigationProtocol> navigationService;

/**
 *  初始化参数
 */
@property (copy, nonatomic) NSDictionary *params;

/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;

/**
 *  副标题
 */
@property (copy, nonatomic) NSString *subtitle;

/**
 *  回调
 */
@property (copy, nonatomic) SJCallback callbackCommand;


/**
 *  返回
 */
@property (copy, nonatomic,readonly) SJCallback backCommand;

/**
 *  统一处理vm里面的所有错误
 */
@property (copy, nonatomic, readonly) SJCallback errors;

/**
 *  统一处理vm里面的所有IOLoading提示
 */
@property (copy, nonatomic, readonly) SJCallback iOLoadings;

/**
*  统一处理vm里面的所有Alert提示
*/
//@property (copy, nonatomic, readonly) SJCallback alert;


/**
 *  是否在初始化时加载本地数据
 */
@property (assign, nonatomic) BOOL shouldFetchLocalDataOnViewModelInitialize;


@property (assign, nonatomic) BOOL requestDidFinished;

/**
 * 是否在viewDidLoad后加载远程数据
 */
@property (assign, nonatomic) BOOL shouldRequestRemoteDataOnViewDidLoad;

/**
 * 请求远程数据command
 */
@property (copy, nonatomic, readonly) SJRequestApiCallback requestRemoteDataCommand;

///**
// * fetch本地数据command
// */
@property (copy, nonatomic, readonly) SJCallback fetchLocalDataCommand;


/**
 *  初始化方法
 */
- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params;

//通过此消息告知VC 开始绑定数据


/**
 *  初始化一些操作或者参数， 在-initWithServices:params:后执行
 */
@optional
- (void)initialize;

@end


