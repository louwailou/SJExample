//
//  SJIndexViewController.m
//  SJExample
//
//  Created by Sun on 2018/3/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJIndexViewController.h"

@interface SJIndexViewController ()

@end

@implementation SJIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // present nav
    // push
    UIButton * presetNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [presetNav setTitle:@"新闻" forState:UIControlStateNormal];
    [presetNav setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:presetNav];
    [presetNav addTarget:self.viewModel action:@selector(presetVC) forControlEvents:UIControlEventTouchUpInside];
    [presetNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(100);
        make.left.equalTo(self.view).mas_offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel{
    [super bindViewModel];
    
    
}
- (BOOL)enableBackBarButton{
    return false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
