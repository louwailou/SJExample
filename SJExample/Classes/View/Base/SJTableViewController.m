//
//  SJTableViewController.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJTableViewController.h"
#import "SJTableViewModelProtocol.h"
@interface SJTableViewController ()

@property (weak, nonatomic, readwrite)UISearchBar *searchBar;
@property (weak, nonatomic, readwrite)UITableView *tableView;
@property (strong, nonatomic, readonly) id<SJTableViewModelProtocol> viewModel;
@end

@implementation SJTableViewController

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]){
        self.tableView = (UITableView *)view;
    }
}


- (instancetype)initWithViewModel:(id<SJViewModelProtocol>)viewModel{
     self = [super initWithViewModel:viewModel];
    if (self) {
        if (self.viewModel.shouldPullToRefresh) {
            [self.tableView.mj_header beginRefreshing];
        }else{
#pragma mark 发送网络请求
            __weak typeof(self) weakSelf = self;
            
            [self aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^{
                if (weakSelf.viewModel.shouldPullToRefresh) {
                    [weakSelf.tableView.mj_header beginRefreshing];
                }else{
                    weakSelf.viewModel.requestRemoteDataCommand(nil, nil);
                }
                
            } error:NULL];
            
           
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    if (self.viewModel.shouldPullToRefresh) {
        
        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            
            self.viewModel.page = 1;
        
            [self.tableView.mj_header endRefreshing];

        }];
        
//        [[self.viewModel.pullRefreshTrigger takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//            @strongify(self)
//            [self.tableView.mj_header beginRefreshing];
//        }];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView.emptyDataSetDelegate = nil;
    _tableView.emptyDataSetSource = nil;
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    if (self.searchBar != nil) {
//        if (self.viewModel.sectionIndexTitles.count != 0) {
//            return @[];
//        }
//    }
    return self.viewModel.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (self.searchBar != nil) {
        if (index == 0) {
            [tableView scrollRectToVisible:self.searchBar.frame animated:NO];
        }
        return index - 1;
    }
    return index;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.viewModel.didSelectCommand(indexPath,nil);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.keyword = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    searchBar.text = nil;
    self.viewModel.keyword = nil;
}

-(BOOL)useDefaultLoadingErrorPage{
    return NO;
}

-(BOOL)enableDefaultFooter{
    return YES;
}
#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (_isError) {
        return  nil;
    }
    return  [[NSAttributedString alloc] initWithString:[self emptyDataDesc] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (_isError){
        return [super imageForEmptyDataSet:scrollView];;
    }
    return [self emptyDataImage];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (_isError) {
        return [super buttonTitleForEmptyDataSet:scrollView forState:state];
    }
    return nil;
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (_isError) {
        return [super titleForEmptyDataSet:scrollView];;
    }
    return [[NSAttributedString alloc] initWithString:[self emptyDataTitle] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [super emptyDataSetShouldDisplay:scrollView] || self.viewModel.dataSource == nil || !self.viewModel.dataSource.count;
}

-(void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    if ([self useDefaultLoadingErrorPage] && !self.viewModel.shouldPullToRefresh) {
        self.viewModel.requestRemoteDataCommand(nil,nil);
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}

-(void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    if (!self.viewModel.shouldPullToRefresh) {
         self.viewModel.requestRemoteDataCommand(nil,nil);
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}

-(UIImage *)emptyDataImage{
    return [UIImage imageNamed:@"reload"];
}

-(NSString *)emptyDataTitle{
    return @"暂时没有数据";
}

-(NSString *)emptyDataDesc{
    return @"";
}
@end
