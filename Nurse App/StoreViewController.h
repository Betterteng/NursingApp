//
//  StoreViewController.h
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) IBOutlet UIWebView* webView;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@end
