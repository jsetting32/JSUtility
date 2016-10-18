//
//  JSJoystickView.m
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSJoystickView.h"

#define STICK_CENTER_TARGET_POS_LEN 20.0f

@interface JSJoystickView()
@property (assign, nonatomic) CGRect rect;
@property (assign, nonatomic) CGPoint mCenter;

@property (strong, nonatomic) UIImageView *stickViewBase;
@property (strong, nonatomic) UIImageView *stickView;

@property (strong, nonatomic) UIImage *imgStickNormal;
@property (strong, nonatomic) UIImage *imgStickHold;
@end

@implementation JSJoystickView

static NSString * const stickImageNormal = @"stick_normal.png";
static NSString * const stickImagePressed = @"stick_hold.png";

- (instancetype)init {
    if (!(self = [super init])) return nil;
    [self initStick:CGRectZero];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initStick:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (!(self = [super initWithCoder:coder])) return nil;
    [self initStick:CGRectZero];
    return self;
}

- (void)initStick:(CGRect)rect {
    NSAssert(rect.size.width == rect.size.height, @"The rect must have square dimensions");
    NSAssert(rect.size.height > 128, @"The rect must be greater than 128 pixels");

    self.imgStickNormal = [UIImage imageNamed:stickImageNormal];
    self.imgStickHold = [UIImage imageNamed:stickImagePressed];
    self.stickView.image = self.imgStickNormal;
    self.mCenter = CGPointMake(rect.size.width / 2, rect.size.height / 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)informDelegate:(CGPoint)dir {
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSJoystickView:didMakeTouchEvent:)]) {
        [self.delegate JSJoystickView:self didMakeTouchEvent:[NSValue valueWithCGPoint:dir]];
    }
}

- (void)stickMoveTo:(CGPoint)deltaToCenter {
    CGRect fr = self.stickView.frame;
    fr.origin.x = deltaToCenter.x;
    fr.origin.y = deltaToCenter.y;
    self.stickView.frame = fr;
}

- (void)touchEvent:(NSSet *)touches {

    if ([touches count] != 1) return;
    
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if (view != self) return;
    
    CGPoint touchPoint = [touch locationInView:view];
    CGPoint dtarget, dir;
    dir.x = touchPoint.x - self.mCenter.x;
    dir.y = touchPoint.y - self.mCenter.y;
    double len = sqrt(dir.x * dir.x + dir.y * dir.y);

    if (len < 10.0 && len > -10.0) {
        // center pos
        dtarget.x = 0.0;
        dtarget.y = 0.0;
        dir.x = 0;
        dir.y = 0;
    } else {
        double len_inv = (1.0 / len);
        dir.x *= len_inv;
        dir.y *= len_inv;
        dtarget.x = dir.x * STICK_CENTER_TARGET_POS_LEN;
        dtarget.y = dir.y * STICK_CENTER_TARGET_POS_LEN;
    }
    [self stickMoveTo:dtarget];
    
    [self informDelegate:dir];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.stickView.image = self.imgStickHold;
    [self touchEvent:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchEvent:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.stickView.image = self.imgStickNormal;
    CGPoint dtarget, dir;
    dir.x = dtarget.x = 0.0;
    dir.y = dtarget.y = 0.0;
    [self stickMoveTo:dtarget];
    
    [self informDelegate:dir];
}

@end
