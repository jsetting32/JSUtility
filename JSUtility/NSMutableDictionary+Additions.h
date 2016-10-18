//
//  NSMutableDictionary+Additions.h
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Additions)
- (void)setSafeObject:(nonnull id)object forSafeKey:(nonnull id <NSCopying>)key;
- (void)removeObjectBySafeKey:(nonnull id)key;
@end
