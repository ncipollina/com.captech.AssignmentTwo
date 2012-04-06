//
//  QuakeTableViewCell.h
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuakeTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (retain, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (retain, nonatomic) IBOutlet UIView *viewForBackground;

@end
