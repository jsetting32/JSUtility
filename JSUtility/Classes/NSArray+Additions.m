//
//  NSArray+Utilities.m
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray(Additions)

- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending {
    NSComparisonResult (^sortBlock)(id, id) = ^(id a, id b)
    {
        if ([a respondsToSelector:NSSelectorFromString(key)] && [b respondsToSelector:NSSelectorFromString(key)]) {
            if (ascending) {
                if ([a valueForKey:key] > [b valueForKey:key]) return NSOrderedDescending;
                if ([a valueForKey:key] < [b valueForKey:key]) return NSOrderedAscending;
                return NSOrderedSame;
            } else {
                if ([a valueForKey:key] > [b valueForKey:key]) return NSOrderedAscending;
                if ([a valueForKey:key] < [b valueForKey:key]) return NSOrderedDescending;
                return NSOrderedSame;
            }
        }
        return NSOrderedSame;
    };
    
    return [self sortedArrayUsingComparator:sortBlock];
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) return nil;
    return [self objectAtIndex:index];
}

- (BOOL)compareEquality:(NSArray *)array {
    return [[array sortedArrayUsingSelector:@selector(compare:)] isEqualToArray:
            [self sortedArrayUsingSelector:@selector(compare:)]];
}

@end
