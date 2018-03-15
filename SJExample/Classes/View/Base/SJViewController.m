//
//  SJViewController.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewController.h"

@interface SJViewController ()
@property (strong, nonatomic, readwrite) id<SJViewModelProtocol> viewModel;
@property (strong, nonatomic, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (strong, nonatomic) UIScrollView *errorReloadView;
@property (assign, nonatomic) BOOL isError;
@property (copy, nonatomic) NSString *errorMsg;
@end

@implementation SJViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SJViewController *viewController = [super allocWithZone:zone];
    
   
    [viewController
      aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^{
         // 开始网络请求
          [viewController.viewModel setShouldRequestRemoteDataOnViewDidLoad:YES];
          
      } error:NULL];
    
    return viewController;
}

- (SJViewController *)initWithViewModel:(id<SJViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        __weak typeof(self) weakSelf = self;
        if ([self.viewModel respondsToSelector:@selector(setRequestDidFinished:)]) {
            [((NSObject*)self.viewModel) aspect_hookSelector:@selector(setRequestDidFinished:) withOptions:AspectPositionAfter usingBlock:^{
#pragma mark 隐藏loading
                
                // 绑定VM
                [weakSelf bindViewModel];
                
            } error:NULL];
        }
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}
- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0], NSForegroundColorAttributeName:[UIColor sj_colorFromString:@"#FFFFFF"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor sj_colorFromString:@"#C70000"];
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([self useDefaultLoadingErrorPage]) {
        
//        if (self.viewModel.requestRemoteDataCommand && !self.errorReloadView.superview) {
//            [self showErrorLoadingView];
//        }
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self enableBackBarButton]){
        
        // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backIcon style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemClicked:)];
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [leftButton setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }else{
        self.navigationItem.hidesBackButton = YES;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark logic

-(void)leftBarItemClicked:(id)sender{
    self.viewModel.backCommand(nil,nil);
}

- (UIScrollView *)errorReloadView{
    if (!_errorReloadView) {
        _errorReloadView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _errorReloadView.backgroundColor = [UIColor whiteColor];
        _errorReloadView.layer.zPosition = 10;
        _errorReloadView.emptyDataSetSource = self;
        _errorReloadView.emptyDataSetDelegate = self;
    }
    return _errorReloadView;
}

-(void)showErrorLoadingView{
    if (!self.errorReloadView.superview) {
        [self.view addSubview:self.errorReloadView];
        [self.errorReloadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuide);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            self.errorReloadView.alpha = 1;
        }];
    }
    [self.errorReloadView reloadEmptyDataSet];
}

-(void)hideErrorLoadingView{
    if (self.errorReloadView.superview) {
        [UIView animateWithDuration:0.25 animations:^{
            self.errorReloadView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.errorReloadView removeFromSuperview];
        }];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self useOriginalNavigationBarStyle] ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}



#pragma mark - DZNEmptyDataSetSource

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor whiteColor];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return  [[NSAttributedString alloc] initWithString:self.errorMsg attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"no_network"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [[NSAttributedString alloc] initWithString:@"点击重试" attributes:@{NSForegroundColorAttributeName:[UIColor sj_colorFromString:@"#FF4093FF"],NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isError;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(scrollView.contentInset.top - scrollView.contentInset.bottom) / 2);
}

-(void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    self.viewModel.requestRemoteDataCommand(nil,nil);
}

-(void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    self.viewModel.requestRemoteDataCommand(nil,nil);
}

#pragma mark 

- (BOOL)enableBackBarButton{
    return YES;
}

- (BOOL)useOriginalNavigationBarStyle{
    return NO;
}

- (BOOL)useDefaultLoadingErrorPage{
    return YES;
}

/**
 *  设置点击界面收起键盘
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
