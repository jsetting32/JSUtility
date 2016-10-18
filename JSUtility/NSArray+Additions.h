//
//  NSArray+Additions.h
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Additions)
- (NSArray *)sortedArrayWithKey:(NSString *)key ascending:(BOOL)ascending;
- (id)safeObjectAtIndex:(NSUInteger)index;
- (BOOL)compareEquality:(NSArray *)array;
@end
