//
//  SJViewModel.m
//  SJExample
//
//  Created by Sun on 2018/3/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJViewModel.h"
@interface SJViewModel()

@property (strong, nonatomic,  readwrite) id<SJViewModelServicesProtocol> services;
@property (weak, nonatomic,  readwrite) id<SJNavigationProtocol> navigationService;
@property (copy, nonatomic,readwrite) SJCallback errors;
@property (copy, nonatomic, readwrite) SJCallback iOLoadings;


@property (copy, nonatomic, readwrite) SJCallback backCommand;


@end


@implementation SJViewModel

@synthesize params = _params;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize shouldFetchLocalDataOnViewModelInitialize = _shouldFetchLocalDataOnViewModelInitialize;
@synthesize shouldRequestRemoteDataOnViewDidLoad = _shouldRequestRemoteDataOnViewDidLoad;

@synthesize callbackCommand = _callbackCommand;
@synthesize requestRemoteDataCommand = _requestRemoteDataCommand;
@synthesize fetchLocalDataCommand = _fetchLocalDataCommand;
@synthesize requestDidFinished = _requestDidFinished;


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SJViewModel *viewModel = [super allocWithZone:zone];
    

    [viewModel
      aspect_hookSelector:@selector(initWithServices:params:) withOptions:AspectPositionAfter usingBlock:^{
           [viewModel initialize];
      } error:NULL];
    
    return viewModel;
}

- (instancetype)initWithServices:(id<SJViewModelServicesProtocol>)services params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.title    = params[@"title"];
        self.services = services;
        self.params   = params;
        
       // self.shouldFetchLocalDataOnViewModelInitialize = YES;
        
     
//        [[self.services.accountService.loginStatus
//          takeUntil:self.rac_willDeallocSignal]
//         subscribeNext:^(id x) {
//             @strongify(self)
//             if (self.subscribedLoginStatusCallback) {
//                 self.subscribedLoginStatusCallback([x boolValue]);
//             }
//         }];
    }
    return self;
}

#pragma mark logic

- (void)initialize {
    
}


#pragma mark setter

-(id<SJNavigationProtocol>)navigationService{
    return self.services;
}

- (SJCallback)backCommand{
    __weak typeof(self) weakSelf = self;
    
    SJCallback callback =  ^(NSDictionary*params, NSError *error){
       
          [weakSelf.services pop:YES];
    };
    return callback;
}

#pragma mark 执行所有的网络请求，可能有一个或者多个
- (SJRequestApiCallback)requestRemoteDataCommand{
   
    SJRequestApiCallback callback =  ^(NSDictionary*params, NSString *api){
       // 添加具体的请求逻辑 请求完成将requestDidFinished 设置Yes
        
        self.requestDidFinished = YES;
    };
    return callback;
}
- (SJCallback)fetchLocalDataCommand{
   
    return nil;
}


-(void)setShouldFetchLocalDataOnViewModelInitialize:(BOOL)shouldFetchLocalDataOnViewModelInitialize{
    _shouldFetchLocalDataOnViewModelInitialize = shouldFetchLocalDataOnViewModelInitialize;
    if (shouldFetchLocalDataOnViewModelInitialize) {
        
    }
}
-(void)setShouldRequestRemoteDataOnViewDidLoad:(BOOL)shouldRequestRemoteDataOnViewDidLoad{
    _shouldRequestRemoteDataOnViewDidLoad = shouldRequestRemoteDataOnViewDidLoad;
   
        if (shouldRequestRemoteDataOnViewDidLoad) {
            self.requestRemoteDataCommand(nil, nil);
        }
}
- (void)setRequestDidFinished:(BOOL)requestDidFinished{
    _requestDidFinished = requestDidFinished;
#pragma mark hide ioLoading
    
}

@end
