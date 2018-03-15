//
//  SJItemViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJItemViewModel.h"
#import "SJViewModel.h"
@interface SJItemViewModel()
@property (weak, nonatomic, readwrite) NSObject<SJViewModelProtocol> *hostViewModel;
@end

@implementation SJItemViewModel

@synthesize callbackCommand = _callbackCommand;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SJItemViewModel *viewModel = [super allocWithZone:zone];
    return viewModel;
}

-(instancetype)initWithHostViewModel:(id<SJViewModelProtocol>)viewModel dataModel:(id)dataModel{
    if (self = [super init]) {
         [viewModel initialize];
        self.hostViewModel = (SJViewModel<SJViewModelProtocol> *)viewModel;
    }
    return self;
}

-(void)initialize{
    
}
@end
