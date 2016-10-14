//
//  JSTextFieldCardNumber.m
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSTextFieldCardNumber.h"
#import "NSString+CardVerification.h"

@interface JSTextFieldCardNumber()
@property (strong, nonatomic) UIImageView *imageViewCard;
@property (strong, nonatomic) CAShapeLayer *shadowLayer;
@property (strong, nonatomic) UITextRange *previousSelection;
@property (strong, nonatomic) NSString *previousTextFieldContent;
@end

@implementation JSTextFieldCardNumber

- (instancetype)init {
    if (!(self = [super init])) return nil;
    [self textFieldCardNumber];
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    [self textFieldCardNumber];
    [self commonInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self textFieldCardNumber];
    [self commonInit];
    return self;
}

// Unless overriden, we want this text field to be the delegate,
// to handle all the logic of credit card verification
- (void)textFieldCardNumber {
  
    [self setDelegate:self];
    
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    // When any change of the text field is made, we want a method to be called
    [self addTarget:self action:@selector(reformatAsCardNumber) forControlEvents:UIControlEventEditingChanged];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self updateShadow];
}

- (void)commonInit {
    [self setShowCardImage:YES];
    [self setShadowColor:[UIColor redColor]];
    [self setShadowRadius:5.0f];
    [self setFont:[UIFont fontWithName:[self.font fontName] size:10]];
    [self setPlaceholder:@"●●●● ●●●● ●●●● ●●●●"];
    [self layoutIfNeeded];

    self.imageViewCard = [[UIImageView alloc] initWithImage:[NSString cardImage:kJSCardTypeInvalid]];
    [self.imageViewCard setContentMode:UIViewContentModeScaleAspectFit];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setLeftView:self.imageViewCard];
}

- (void)setShowShadow:(BOOL)showShadow {
    if (showShadow) {
        [self.layer addSublayer:self.shadowLayer];
    } else {
        [self.shadowLayer removeFromSuperlayer];
    }
}

- (void)showErrorShadow:(BOOL)show {
    if (show) {
        [self.layer addSublayer:self.shadowLayer];
    } else {
        [self.shadowLayer removeFromSuperlayer];
    }
}

- (void)setShowCardImage:(BOOL)showCardImage {
    if (!showCardImage) {
        [self setLeftView:nil];
    }
}

- (void)setCardNumberText:(NSString *)text showCardImage:(BOOL)showCardImage showErrorShadow:(BOOL)showShadow {
    NSString *trimmedString = [text protectedCardString];
    NSMutableString *cardNumber = [NSMutableString string];
    for (int i = 0; i < 12; i++) {
        [cardNumber appendString:kJSTextFieldCircleCharacter];
    }
    [cardNumber appendString:trimmedString];
    
    NSUInteger length = [text length];
    NSString *cardNumberWithSpaces = [cardNumber insertSpacesForCardType:[text cardType] preserveCursorPosition:&length];
    [self setText:cardNumberWithSpaces];
    
    if (!showCardImage) {
        [self setLeftView:nil];
    }
    
    if (!showShadow) {
    }
}

// Version 1.2
// Source and explanation: http://stackoverflow.com/a/19161529/1709587
- (void)reformatAsCardNumber {
    if ([self.text containsString:kJSTextFieldCircleCharacter]) {
        [self setText:nil];
    }
    
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    NSUInteger targetCursorPosition = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    
    NSString *cardNumberWithoutSpaces = [self.text removeNonDigitsAndPreserveCursorPosition:&targetCursorPosition];
    
    JSCardType cardType = [cardNumberWithoutSpaces cardType];

    if ([cardNumberWithoutSpaces length] > 19) {
        // If the user is trying to enter more than 19 digits, we prevent
        // their change, leaving the text field in its previous state.
        // While 16 digits is usual, credit card numbers have a hard
        // maximum of 19 digits defined by ISO standard 7812-1 in section
        // 3.8 and elsewhere. Applying this hard maximum here rather than
        // a maximum of 16 ensures that users with unusual card numbers
        // will still be able to enter their card number even if the
        // resultant formatting is odd.
        [self setText:self.previousTextFieldContent];
        self.selectedTextRange = self.previousSelection;
        return;
    }
    
    [self handleShowingShadowLogic:cardNumberWithoutSpaces type:cardType];
    
    [self.imageViewCard setImage:[NSString cardImage:cardType]];
    
    NSString *cardNumberWithSpaces = [cardNumberWithoutSpaces insertSpacesForCardType:cardType preserveCursorPosition:&targetCursorPosition];
    
    self.text = cardNumberWithSpaces;
    UITextPosition *targetPosition = [self positionFromPosition:[self beginningOfDocument] offset:targetCursorPosition];
    
    [self setSelectedTextRange:[self textRangeFromPosition:targetPosition toPosition:targetPosition]];
}

- (void)handleShowingShadowLogic:(NSString *)cardNumber type:(JSCardType)type {
    if (self.errorType == kJSTextFieldCardNumberErrorTypeNever) return;
    
    if ([cardNumber length] == 0) {
        [self setShowShadow:NO];
        return;
    }
    
    if (self.errorType == kJSTextFieldCardNumberErrorTypeAlways) {
        if (type == kJSCardTypeInvalid) {
            [self setShowShadow:YES];
            return;
        }
        
        if (![cardNumber isValidCardLengthWithType:type]) {
            [self setShowShadow:YES];
            return;
        }
        
        if (![cardNumber luhnCheck]) {
            [self setShowShadow:YES];
            return;
        }
        [self setShowShadow:NO];
        return;
    }
    
    if (self.errorType == kJSTextFieldCardNumberErrorTypeCardNumberLength) {
        
        return;
    }

    if (self.errorType == kJSTextFieldCardNumberErrorTypeCardNumberLengthHarsh) {
        
        return;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Note textField's current state before performing the change, in case
    // reformatTextField wants to revert it
    self.previousTextFieldContent = textField.text;
    self.previousSelection = textField.selectedTextRange;
    return YES;
}

// This simply moves the left view of the text field to the right 5 points
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += 5;
    return textRect;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect textRect = [super clearButtonRectForBounds:bounds];
    textRect.origin.x -= 5;
    return textRect;
}

- (void)updateShadow {
    [self.shadowLayer setFrame:[self bounds]];
    
    // Create the larger rectangle path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectInset(self.bounds, -42, -42));
    
    // Add the inner path so it's subtracted from the outer path.
    // someInnerPath could be a simple bounds rect, or maybe
    // a rounded one for some extra fanciness.
    CGPathRef someInnerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    CGPathAddPath(path, NULL, someInnerPath);
    CGPathCloseSubpath(path);
    
    [self.shadowLayer setPath:path];
    CGPathRelease(path);
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:someInnerPath];
    [self.shadowLayer setMask:maskLayer];
}

#pragma mark - Initializers
- (CAShapeLayer *)shadowLayer {
    if (!_shadowLayer) {
        _shadowLayer = [CAShapeLayer layer];
        [_shadowLayer setShadowColor:[self.shadowColor CGColor]];
        [_shadowLayer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [_shadowLayer setShadowOpacity:1.0f];
        [_shadowLayer setShadowRadius:self.shadowRadius];
        
        // Causes the inner region in this example to NOT be filled.
        [_shadowLayer setFillRule:kCAFillRuleEvenOdd];
        
        [self updateShadow];
    }
    return _shadowLayer;
}

@end
