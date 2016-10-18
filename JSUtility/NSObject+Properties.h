//
//  NSObject+Properties.h
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Properties)
- (NSDictionary *)propertiesOfObject;
+ (NSDictionary *)propertiesOfClass:(Class)classObject;
+ (NSDictionary *)propertiesOfSubclass:(Class)classObject;
@end
