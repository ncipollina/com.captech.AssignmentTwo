//
//  Quake.h
//  AssignmentTwo
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quake : NSObject

@property (copy) NSString *title;
@property (copy) NSNumber *longitude;
@property (copy) NSNumber *latitude;
@property (copy) NSString *url;
@property (copy) NSNumber *magnitude;
@property (copy) NSDate *date;

- (id)initQuakeWithTitle:(NSString *)title longitude:(NSNumber *)longitude latitude:(NSNumber *)latitude url:(NSString *)url magnitude:(NSNumber *)magnitude date:(NSDate *)date;

@end
