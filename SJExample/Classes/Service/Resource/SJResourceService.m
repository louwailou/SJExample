//
//  SJResourceService.m
//  SJExample
//
//  Created by Sun on 2018/3/7.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SJResourceService.h"
#define STORE_VERSION_KEY @"stored_app_verison_for_resource"
#define STORE_STRING_VERSION_KEY @"stored_string_verison_for_resource"

@interface SJResourceService()

@property (strong, nonatomic) NSString *bundlePath;
//@property (strong, nonatomic) JFResourceManager *resourceManager;
@property (strong, nonatomic) NSCache *imageCache;
@end

@implementation SJResourceService
+ (void)load{
    [self shared];
}

+ (SJResourceService*)shared{
    static SJResourceService* shareInstance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SJResourceService alloc] init];
    });
    return shareInstance;
}

/*
+ (NSString *)readLastAppVerison {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appverison = [userDefaults objectForKey:STORE_VERSION_KEY];
    return appverison;
}

+ (void)saveCurrentAppVerison {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self appVersion] forKey:STORE_VERSION_KEY];
    [userDefaults synchronize];
}

+ (NSString *)appVersion{
    NSString *_appVersion;
    if (NSClassFromString(@"XCTest")) {
        NSDictionary *infoDictionary =  [[NSBundle bundleForClass:[self class]] infoDictionary];
        _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }else{
        NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    _appVersion = (_appVersion&&_appVersion.length > 0)?_appVersion:@"unknown";
    return _appVersion;
}


-(instancetype)init{
    if (self = [super init]) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShuJi" ofType:@"bundle"];
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *resourceDir = [documentsDirectory stringByAppendingPathComponent:@"Resource"];
        
        NSString *themeBundlePath = [resourceDir stringByAppendingPathComponent:@"ShuJi.bundle"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        void (^resourcHandleBlock)(NSString *themeBundlePath, BOOL removeExsitThemeBundle) = ^(NSString *themeBundlePath, BOOL removeExsitThemeBundle){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSError *error;
                if (removeExsitThemeBundle) {
                    [fileManager removeItemAtPath:themeBundlePath error:&error];
                    if (error) {
#ifdef DEBUG
                        NSLog(@"SJResourceService delete bundle error:%@",error);
#endif
                    }
                }
              
            });
        };
        
        BOOL isDir;
        if ([fileManager fileExistsAtPath:themeBundlePath isDirectory:&isDir]) {
            if ([[SJResourceService readLastAppVerison] isEqualToString: [SJResourceService appVersion]]) {
                bundlePath = themeBundlePath;
            }else{
                [SJResourceService saveCurrentAppVerison];
                resourcHandleBlock(themeBundlePath,YES);
            }
        }else{
            resourcHandleBlock(themeBundlePath,NO);
        }
        
        _bundlePath = bundlePath;
        
        NSBundle *bundle = [NSBundle bundleWithPath:_bundlePath];
        if (bundle) {
            _resourceManager = [[JFResourceManager alloc] initWithBundle:bundle];
        }
    
    }
    return self;
}


-(NSCache *)imageCache{
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

#pragma mark - public
- (UIImage *)imageForName:(NSString *)name{
    UIImage *img = [self.imageCache objectForKey:name];
    if (!img) {
        img = [self.resourceManager imageForName:name];
        if (img) {
            [self.imageCache setObject:img forKey:name];
        }
    }
    return img;
}

- (NSString *)stringForKey:(NSString *)key{
    return [self.resourceManager stringForKey:key];
}

- (UIFont *)fontForKey:(NSString *)key{
    return [self.resourceManager fontForKey:key];
}

- (UIColor *)colorForKey:(NSString *)key{
    return [self.resourceManager colorForKey:key];
}

- (CGFloat)dimenForKey:(NSString *)key{
    return [self.resourceManager dimenForKey:key];
}

*/
@end
