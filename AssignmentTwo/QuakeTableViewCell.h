//
//  QuakeTableViewCell.h
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quake;

@interface QuakeTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (retain, nonatomic) Quake *quakeData;
@end
