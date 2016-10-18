//
//  JSJoystickView.h
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSJoystickViewDelegate;
@interface JSJoystickView : UIView
@property (weak, nonatomic) id <JSJoystickViewDelegate> delegate;
@end

@protocol JSJoystickViewDelegate <NSObject>
- (void)JSJoystickView:(JSJoystickView *)view didMakeTouchEvent:(NSValue *)touchValue;
@end

