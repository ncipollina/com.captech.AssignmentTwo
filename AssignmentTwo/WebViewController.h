//
//  WebViewControllerViewController.h
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quake.h"

@interface WebViewController : UIViewController
@property (strong) IBOutlet UIWebView *webView;
@property (strong) Quake *quake;

@end
