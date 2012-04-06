//
//  WebViewControllerViewController.m
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView = _webView;
@synthesize quake = _quake;
- (void)viewWillAppear:(BOOL)animated {
    
    NSURL *url = [NSURL URLWithString:self.quake.url];    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
}

- (void)dealloc{
    [_webView release];
    [_quake release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
