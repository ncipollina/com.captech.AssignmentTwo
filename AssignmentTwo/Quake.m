//
//  Quake.m
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Quake.h"

@implementation Quake

@synthesize title = _title;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize url = _url;
@synthesize magnitude = _magnitude;
@synthesize date = _date;

- (id)initQuakeWithTitle:(NSString *)title longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude url:(NSString *)url magnitude:(NSNumber *)magnitude date:(NSDate *)date{
    
    if (self == [super init]){
        _title = [title copy];
        _longitude = [longitude copy];
        _latitude = [latitude copy];
        _url = [url copy];
        _magnitude = [magnitude copy];
        _date = [date copy];
    }
    return self;
}

- (BOOL)isEqual:(Quake *)object{
    return [self.date isEqualToDate:object.date];
}

- (void)dealloc{
    [_title release];
    [_longitude release];
    [_latitude release];
    [_url release];
    [_magnitude release];
    [_date release];
    [super dealloc];
}
@end
