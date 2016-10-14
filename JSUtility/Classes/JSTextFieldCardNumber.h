//
//  JSTextFieldCardNumber.h
//  Pods
//
//  Created by John Setting on 10/12/16.
//
//

#import <UIKit/UIKit.h>

/*
 * TODO:
 * 1) Need to do correct spacing for other cards instead of Visa, etc. (4 spaces), theres 
 * American express that does a space after 4 characters then another after the 10 somethign character :/
 * 2) Need to come up with the logic for displaying a more LOGICAL error shadow
 */
 

static NSString *const kJSTextFieldCircleCharacter = @"●";

typedef NS_ENUM(NSInteger, kJSTextFieldCardNumberErrorType) {
    
    // Setting this will make sure the error shadow never shows
    kJSTextFieldCardNumberErrorTypeNever = -1,
    
    // Setting this will always display the error shadow if the card number just isnt valid
    // Cases:
    // 1) Not enough characters (< 12)
    // 2) Doesnt follow a Partial IIN of any cards (1111)
    // 3) If the number follows a Partial IIN but doesnt have enough characters
    // 4) If the number follows a
    kJSTextFieldCardNumberErrorTypeAlways = 0,
    kJSTextFieldCardNumberErrorTypeCardNumberLength,
    kJSTextFieldCardNumberErrorTypeCardNumberLengthHarsh
};

@interface JSTextFieldCardNumber : UITextField
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) CGFloat shadowRadius;
@property (assign, nonatomic) kJSTextFieldCardNumberErrorType errorType;
@property (assign, nonatomic) BOOL showCardImage;

// If you set this, it will mainly be for the reason, the card isnt valid when submitted for verification
// Two suggestions with this,
//
// 1) Once they submit the card and the value returned is invalid, display the error shadow, then dont dismiss the shadow
// until they get a valid card number verified from the card holder API (e.g Stripe, Vantiv, Square, etc.)
// 2) Once they submit the card and the value returned is invalid, display the error shadow, but dismiss it
// once they start making changes to the text
- (void)showErrorShadow:(BOOL)show;

// Use this when you have previous information of a card that has been saved.
// Set the text field and it will display only circle characters followed by the last 4 digits of the card number
- (void)setCardNumberText:(NSString *)text;
@end
