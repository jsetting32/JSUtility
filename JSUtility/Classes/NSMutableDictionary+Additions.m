//
//  NSMutableDictionary+Additions.m
//  JSUtility
//
//  Created by John Setting on 8/9/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary(Additions)

- (void)setSafeObject:(id)object forSafeKey:(id)key {
    if (!object || !key) return;
//    [self setObject:object ?: [NSNull null] forKey:key ?: [NSNull null]];
//    [self setObject:object forKey:key];
    [self setObject:object ?: @"" forKey:key ?: @""];
}

- (void)removeObjectBySafeKey:(id)key {
    if (!key) return;
    [self removeObjectForKey:key];
}

@end
