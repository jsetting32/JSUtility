//
//  NSMutableArray+Additions.h
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additions)
- (void)addSafeObject:(nullable id)object;
- (void)removeSafeObjectAtIndex:(NSUInteger)object;
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
- (nonnull NSMutableArray <NSMutableArray <id> *> *)splitArray:(NSInteger)count;
@end
