//
//  SJTableViewController.h
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewController.h"

@interface SJTableViewController : SJViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
/**
 *  搜索框
 */
@property (weak, nonatomic, readonly) UISearchBar *searchBar;

/**
 *  表视图
 */
@property (weak, nonatomic, readonly) UITableView *tableView;


/**
 *  重载数据
 */
- (void)reloadData;

/**
 *  用于在TabelViewDataSource中获取Cell，应在子类中重写
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 *  子类重写，主要作用是Model和View之间的绑定
 *
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;


/**
 是否使用默认footer
 
 */
- (BOOL)enableDefaultFooter;

/**
 *  没有数据的显示图片
 */
- (UIImage *)emptyDataImage;
/**
 *  没有数据标题
 */
- (NSString *)emptyDataTitle;

/**
 *  没有数据描述
 */
- (NSString *)emptyDataDesc;
@end
