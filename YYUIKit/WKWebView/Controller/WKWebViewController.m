//
//  WKWebViewController.m
//  YYUIKit
//
//  Created by Michael on 2019/7/25.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()
//加载网页
@property (strong, nonatomic) WKWebView  *wkWebView;
//进度条
@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation WKWebViewController
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self deleteWebCache];
    //加载本地文件
    [self loadLocalFile];
    //加载网络文件
    //[self loadNetFile];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //方法无效、清除沙盒缓存
    [self deleteWebCache];
}

#pragma mark - 初始化View
- (void)initView
{
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 清除缓存
- (void)deleteWebCache
{
    if([[UIDevice currentDevice].systemVersion floatValue] >=9.0)
    {
        NSSet*websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate*dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }
    else
    {
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        NSString*cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError*errors;
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

#pragma mark - 加载本地文件
- (void)loadLocalFile
{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"tip.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

#pragma mark - 加载网络文件
- (void)loadNetFile
{
    NSString *urlString = @"https://www.baidu.com/";
    NSURL *URL = [NSURL URLWithString:urlString];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:URL]];
}

#pragma mark - KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
        }
        else
        {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - 注销KVO
- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - setter and getter
- (WKWebView *)wkWebView
{
    if (!_wkWebView)
    {
        //偏好设置
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        //这里不要设置字体大小，否则会影响页面展示
        //preferences.minimumFontSize = 16.0;

        //配置信息
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [[WKUserContentController alloc] init];
        configuration.preferences = preferences;

        //初始化
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor whiteColor];
        //取消回弹效果
        _wkWebView.scrollView.bounces = NO;
        //正常速度
        _wkWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _wkWebView;
}

- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 4)];
        _progressView.tintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor blueColor];
    }
    return _progressView;
}
@end
