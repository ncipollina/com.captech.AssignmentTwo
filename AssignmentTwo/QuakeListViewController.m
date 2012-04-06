//
//  QuakeListViewController.m
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuakeListViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement+Extras.h"
#import "NSDate+InternetDateTime.h"
#import "NSArray+Extras.h"
#import "Quake.h"
#import "WebViewController.h"

@interface QuakeListViewController ()

@end

@implementation QuakeListViewController

@synthesize webViewController = _webViewController;
@synthesize allEntries = _allEntries;
@synthesize feeds = _feeds;
@synthesize queue = _queue;

- (void)refresh{
    
    for (NSString *feed in _feeds) {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [_queue addOperation:request];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    [_queue addOperationWithBlock:^{
        
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[request responseData] options:0 error:&error];
        
        if (doc == nil){
            NSLog(@"Failed to parse %@", request.url);
        } else {
            NSMutableArray *quakes = [NSMutableArray array];
            [self parseFeed:doc.rootElement  quakes:quakes];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                for (Quake *entry in quakes) {
                    if (![self.allEntries containsObject:entry]){
                        int insertIdx = [self.allEntries indexForInsertingObject:entry sortedUsingBlock:^(id a, id b){
                            Quake *quake1 = (Quake *) a;
                            Quake *quake2 = (Quake *) b;
                            return [quake1.date compare:quake2.date];
                        }];
                        [self.allEntries insertObject:entry atIndex:insertIdx];
                        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIdx inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                    }
                }
            }];
        }
    }];
}

- (void)parseFeed:(GDataXMLElement *)rootElement quakes:(NSMutableArray *)quakes{
    if ([rootElement.name compare:@"rss"] == NSOrderedSame){
        [self parseQuakes:rootElement quakes:quakes];
    }else {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }
}

- (void)parseQuakes:(GDataXMLElement *)rootElement quakes:(NSMutableArray *)quakes{
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels){
                
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items){
            
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".+<p>Date: ((Mon|Tue|Wed|Thu|Fri|Sat|Sun).+) UTC<br/>.+" options:NSRegularExpressionCaseInsensitive error:&error];
            NSString *description = [item valueForChild:@"description"];
            NSArray *matches = [regex matchesInString:description options:0 range:NSMakeRange(0, [description length])];
            NSString *matchString = nil;
            for (NSTextCheckingResult *match in matches) {
                //NSRange matchRange = [match range];
                NSRange matchRange = [match rangeAtIndex:1];
                matchString = [NSString stringWithFormat:@"%@ +0000", [description substringWithRange:matchRange]];
                NSLog(@"%@", matchString);
            }
            
            NSString *title = [item valueForChild:@"title"];
            NSString *url = [item valueForChild:@"link"];
            NSDate *date = [NSDate dateFromInternetDateTimeString:matchString formatHint:DateFormatHintRFC822];
            NSString *latitudeString = [item valueForChild:@"geo:lat"];
            NSString *longitudeString = [item valueForChild:@"geo:long"];
            NSString *magnitudeString = [item valueForChild:@"dc:subject"];
            NSNumber *longitude = [NSNumber numberWithDouble:[longitudeString doubleValue]];
            NSNumber *latitude = [NSNumber numberWithDouble:[latitudeString doubleValue]];
            NSNumber *magnitude = [NSNumber numberWithDouble:[magnitudeString doubleValue]];
            
            Quake *quake = [[[Quake alloc] initQuakeWithTitle:title longitude:longitude latitude:latitude url:url magnitude:magnitude date:date]autorelease];
            
            [quakes addObject:quake];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *refreshButton =[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)] autorelease];
    
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    self.title = @"Earthquakes";
    self.allEntries = [NSMutableArray array];
    self.queue = [[[NSOperationQueue alloc] init] autorelease];
    self.feeds = [NSArray arrayWithObjects:@"http://earthquake.usgs.gov/earthquakes/shakemap/rss.xml",
                  nil];    
    [self refresh];
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

- (void)dealloc{
    [_allEntries release];
    _allEntries = nil;
    [_queue release];
    _queue = nil;
    [_feeds release];
    _feeds = nil;
    [_webViewController release];
    _webViewController = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Quake *quake = [self.allEntries objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *articleDateString = [dateFormatter stringFromDate:quake.date];
    
    cell.textLabel.text = quake.title;        
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, quake.url];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Quake *quake = [self.allEntries objectAtIndex:indexPath.row];
    if (quake.magnitude.doubleValue >= 7){
        cell.backgroundColor = [UIColor redColor];
    } else if (quake.magnitude.doubleValue >= 5){
        cell.backgroundColor = [[[UIColor alloc] initWithRed:1.0 green:0.4 blue:0.4 alpha:1.0]autorelease]; 
    }
    else 
        cell.backgroundColor = [UIColor whiteColor];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.allEntries removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    if (self.webViewController == nil){
        self.webViewController = [[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle]] autorelease];
    }
    Quake *quake = [self.allEntries objectAtIndex:indexPath.row];
    self.webViewController.quake = quake;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

@end
