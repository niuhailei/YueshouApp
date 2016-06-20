//
//  YSWebViewController.m
//  YueShouApp
//
//  Created by 鄂鸿桢 on 16/6/15.
//  Copyright © 2016年 xiaoke. All rights reserved.
//

#import "YSWebViewController.h"
#import <WebKit/WebKit.h>

@interface YSWebViewController ()

@end

@implementation YSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    YSLog(@"shouldStartLoadWithRequest");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    YSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    YSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    YSLog(@"didFailLoadWithError");
}

@end
