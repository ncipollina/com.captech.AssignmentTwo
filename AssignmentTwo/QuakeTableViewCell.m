//
//  QuakeTableViewCell.m
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuakeTableViewCell.h"

@implementation QuakeTableViewCell
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize viewForBackground = _viewForBackground;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [titleLabel release];
    [dateLabel release];
    [latitudeLabel release];
    [longitudeLabel release];
    [_viewForBackground release];
    [super dealloc];
}
@end
