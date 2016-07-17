//
//  WebViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController()<UIWebViewDelegate>
{
    NSURLRequest* request;
}
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation WebViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_webView setBackgroundColor:[UIColor whiteColor]];
    
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [_webView loadRequest:request];//加载
}


-(void) setUrl:(NSURL *)url
{
    _url = url;//创建URL
    request = [NSURLRequest requestWithURL:_url];//创建NSURLRequest
}

- (void)webViewDidStartLoad:(UIWebView *)webView

{
    
    // starting the load, show the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    
    // finished loading, hide the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    // load error, hide the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    
    NSString* errorString = [NSString stringWithFormat:@"An error occurred:%@",
                             
                             error.localizedDescription];
    
    [self.webView loadHTMLString:errorString baseURL:nil];
    
}

@end
