//
//  NSArray+Extras.h
//  RSSFun
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extras)

typedef NSInteger (^compareBlock)(id a, id b);

- (NSUInteger)indexForInsertingObject:(id)anObject sortedUsingBlock:(compareBlock)compare;

@end
