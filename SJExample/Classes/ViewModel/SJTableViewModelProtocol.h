//
//  SJTableViewModelProtocol.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//
#import "SJViewModelProtocol.h"
@protocol SJTableViewModelProtocol<SJViewModelProtocol>
/**
 *  数据源，嵌套数组dataSource[section][row]
 */
@property (copy, nonatomic) NSArray<NSArray *> *dataSource;

/**
 *  section标题
 */
@property (copy, nonatomic) NSArray<NSString *> *sectionIndexTitles;

/**
 *  当前页
 */
@property (assign, nonatomic) NSUInteger page;

/**
 *  每页数量
 */
@property (assign, nonatomic) NSUInteger perPage;

/**
 *  总数量
 */
@property (assign, nonatomic) NSUInteger totalCount;

/**
 *  是否支持下拉刷新
 */
@property (assign, nonatomic) BOOL shouldPullToRefresh;

/**
 *  是否支持上拉刷新
 */
@property (assign, nonatomic) BOOL shouldInfiniteScrolling;

/**
 *  搜索的关键词
 */
@property (copy, nonatomic) NSString *keyword;

/**
 *  Cell 选中的Action
 */
@property (copy, nonatomic) SJCellDidSelectCommand didSelectCommand;

/**
 *  触发下拉请求
 */
@property (copy, nonatomic,readonly) SJCallback pullRefreshTrigger;


/**
 *  数据源的offset
 */
- (NSUInteger)offsetForPage:(NSUInteger)page;

/**
 *  根据页数请求服务端数据
 *
 */
- (void)requestRemoteDataWithPage:(NSUInteger)page;

@end
