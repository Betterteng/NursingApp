//
//  StoreViewController.m
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    
    NSString* url = @"https://www.hesta.com.au/";
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor grayColor];
    NSURL* nsUrl = [NSURL URLWithString:url];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
    
    //activity indicater code
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    [self navigationItem].rightBarButtonItem = barButton;
    //[self.activityIndicator startAnimating];
    self.activityIndicator.hidden=YES;
    
}
-(void)createNavigationBar
{
    //hide back button
    self.navigationItem.hidesBackButton=true;
    //Nativation title
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[self activityIndicator] startAnimating];
    self.activityIndicator.hidden=NO;
}

- (void)didFailLoadWithError:(UIWebView *)webView
        didFailLoadWithError:(NSError *)error
{
    [[self activityIndicator] stopAnimating];
    self.activityIndicator.hidden=YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[self activityIndicator] stopAnimating];
    self.activityIndicator.hidden=YES;
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
