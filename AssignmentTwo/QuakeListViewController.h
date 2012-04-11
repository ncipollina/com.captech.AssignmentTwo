//
//  QuakeListViewController.h
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;
@class Reachability;

@interface QuakeListViewController : UITableViewController{
    UINib *cellLoader;
    Reachability *internetReach;
}

@property (retain) NSMutableArray *allEntries;
@property (strong) NSArray *feeds;
@property (strong) NSOperationQueue *queue;
@property (strong, nonatomic) WebViewController *webViewController;

@end
