//
//  NSArray+Extras.m
//  RSSFun
//
//  Created by Nicholas Cipollina on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Extras.h"

@implementation NSArray (Extras)

- (NSUInteger)indexForInsertingObject:(id)anObject sortedUsingBlock:(compareBlock)compare{
    NSUInteger index = 0;
    NSUInteger topIndex = [self count];
    while (index < topIndex) {
        NSUInteger midIndex = (index + topIndex) / 2;
        id testObject = [self objectAtIndex:midIndex];
        if (compare(anObject, testObject) < 0){
            index = midIndex + 1;
        }else {
            topIndex = midIndex;
        }
    }
    return index;
}

@end
