//
//  NSMutableArray+Additions.h
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)
- (void)addSafeObject:(id)object {
    if (!object) return;
    [self addObject:object];
}

- (void)removeSafeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) return;
    [self removeObjectAtIndex:index];
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}

- (NSMutableArray <NSMutableArray <id> *> *)splitArray:(NSInteger)count {
    NSMutableArray *arrayOfArrays = [NSMutableArray array];
    
    NSUInteger itemsRemaining = [self count];
    int j = 0;
    
    while(itemsRemaining) {
        NSRange range = NSMakeRange(j, MIN(count, itemsRemaining));
        NSMutableArray *subarray = [[self subarrayWithRange:range] mutableCopy];
        [arrayOfArrays addObject:subarray];
        itemsRemaining-=range.length;
        j+=range.length;
    }
    return arrayOfArrays;
}
@end
