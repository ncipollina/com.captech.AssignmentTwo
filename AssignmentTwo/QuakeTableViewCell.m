//
//  QuakeTableViewCell.m
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuakeTableViewCell.h"
#import "Quake.h"

@implementation QuakeTableViewCell
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize quakeData = _quakeData;

- (void)setQuakeData:(Quake *)newQuakeData{
    [newQuakeData retain];
    [_quakeData release];
    _quakeData = newQuakeData;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *dateString = [dateFormatter stringFromDate:self.quakeData.date];
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:4];

    self.titleLabel.text = _quakeData.title;
    self.dateLabel.text = dateString;
    self.latitudeLabel.text = [numberFormatter stringFromNumber:self.quakeData.latitude];
    self.longitudeLabel.text = [numberFormatter stringFromNumber:self.quakeData.longitude];
}

- (void)dealloc {
    [titleLabel release];
    [_quakeData release];
    [titleLabel release];
    [dateLabel release];
    [latitudeLabel release];
    [longitudeLabel release];
    [super dealloc];
}
@end
