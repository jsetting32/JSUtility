//
//  NSString+CardVerification.m
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "NSString+CardVerification.h"
#import "JSTextFieldCardNumber.h"

@implementation NSString(CardVerification)

- (NSMutableArray *)toCharArray {
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i=0; i < [self length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [characters addObject:ichar];
    }
    
    return characters;
}

- (BOOL)luhnCheck {
    NSString *removedWhitespaces = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([removedWhitespaces length] < 14) return NO;
    
    NSMutableArray *stringAsChars = [removedWhitespaces toCharArray];
    
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    
    NSNumber *s = @([removedWhitespaces length] - 1);
    
    for (int i = [s intValue]; i >= 0; i--) {
        
        int digit = [(NSString *)[stringAsChars objectAtIndex:i] intValue];
        
        if (isOdd)
            oddSum += digit;
        else
            evenSum += digit/5 + (2*digit) % 10;
        
        isOdd = !isOdd;
    }
    
    return ((oddSum + evenSum) % 10 == 0);
}

- (BOOL)isCardValidWithType:(JSCardType)type {
    return [self luhnCheck] && [self isValidCardLengthWithType:type];
}

- (BOOL)CVVCheckWithType:(JSCardType)type {
    return (type == kJSCardTypeAmericanExpress) ? [self length] == 4 : [self length] == 3;
}

- (JSCardType)cardType {
    NSArray *types = @[@(kJSCardTypeAmericanExpress),
                       //                       @(kJSCardTypeBankcard),
                       //                       @(kJSCardTypeChinaUnionPay),
                       @(kJSCardTypeDankort),
                       @(kJSCardTypeDiners),
//                       @(kJSCardTypeDinersClubCarteBlanche),
//                       //                       @(kJSCardTypeDinersClubEnRoute),
//                       @(kJSCardTypeDinersInternational),
                       //                       @(kJSCardTypeDinersUnitedStatesCanada),
                       @(kJSCardTypeDiscover),
                       @(kJSCardTypeChinaUnionPay),
                       @(kJSCardTypeInstaPayment),
                       @(kJSCardTypeInterPayment),
                       @(kJSCardTypeJCB),
                       //                       @(kJSCardTypeLaser),
                       @(kJSCardTypeMaestro),
                       @(kJSCardTypeMasterCard),
                       //                       @(kJSCardTypeSolo),
                       //                       @(kJSCardTypeSwitch),
                       @(kJSCardTypeUATP),
                       @(kJSCardTypeVisa)];
    __block JSCardType type = kJSCardTypeInvalid;
    [types enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JSCardType _type = [obj integerValue];
        NSPredicate *predicate = [NSString predicateForType:_type];
        BOOL isCurrentType = [predicate evaluateWithObject:self];
        if (isCurrentType) {
            type = _type;
            *stop = YES;
        }
    }];
    
    return type;
}

+ (UIImage *)cardImage:(JSCardType)type {
    if (type == kJSCardTypeAmericanExpress) return [UIImage imageNamed:@"amex.png"];
    if (type == kJSCardTypeBankcard) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeChinaUnionPay) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeDankort) return [UIImage imageNamed:@"dankort.png"];
    if (type == kJSCardTypeDiners) return [UIImage imageNamed:@"diners.png"];
//    if (type == kJSCardTypeDinersClubCarteBlanche) return [UIImage imageNamed:@"diners"];
//    if (type == kJSCardTypeDinersClubEnRoute) return [UIImage imageNamed:@"diners"];
//    if (type == kJSCardTypeDinersInternational) return [UIImage imageNamed:@"diners"];
//    if (type == kJSCardTypeDinersUnitedStatesCanada) return [UIImage imageNamed:@"diners"];
    if (type == kJSCardTypeDiscover) return [UIImage imageNamed:@"discover.png"];
    if (type == kJSCardTypeInstaPayment) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeInterPayment) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeJCB) return [UIImage imageNamed:@"jcb.png"];
    if (type == kJSCardTypeLaser) return [UIImage imageNamed:@"laster.png"];
    if (type == kJSCardTypeMaestro) return [UIImage imageNamed:@"maestro.png"];
    if (type == kJSCardTypeMasterCard) return [UIImage imageNamed:@"mastercard.png"];
    if (type == kJSCardTypeSolo) return [UIImage imageNamed:@"solo.png"];
    if (type == kJSCardTypeSwitch) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeUATP) return [UIImage imageNamed:@"credit.png"];
    if (type == kJSCardTypeVisa) return [UIImage imageNamed:@"visa.png"];
    return [UIImage imageNamed:@"credit.png"];
}

+ (NSPredicate *)predicateForType:(JSCardType)type {
    if (type == kJSCardTypeInvalid) {
        return nil;
    }
    
    // Regex Number Ranges : http://stackoverflow.com/questions/676467/how-to-match-numbers-between-x-and-y-with-regexp
    // Regex Cheat Sheet : http://www.rexegg.com/regex-quickstart.html
    // Card Number Reference : https://en.wikipedia.org/wiki/Payment_card_number
    
    NSString *regex = nil;
    switch (type) {
        case kJSCardTypeAmericanExpress:
            regex = @"^3[47][0-9]{0,}$";
            break;
        case kJSCardTypeBankcard:
            regex = @"^56((10)|(022[1-5]))[0-9]{0,}$";
            break;
        case kJSCardTypeChinaUnionPay:
            regex = @"^62[0-9]{0,}$";
            break;
        // Since one of Dankorts Partial IIN pattern follows Visa's, and that same IIN pattern is co-branded by Visa,
        // we let Visa have Dankorts Partial IIN
        case kJSCardTypeDankort:
//            regex = @"^4((175)|(571))[0-9]{0,}$";
            regex = @"^5019[0-9]{0,}$";
            break;
        // Diners United States Canada has a prefix of 54-55, it is also co branded by MasterCard, so we put the regex in the master card
        case kJSCardTypeDiners:
            regex = @"^((30[0-5][0-9]{0,})|(2((014)|(149))[0-9]{0,})|(3((0[0-5])|((09)|6|8|9))[0-9]{0,}))$";
            break;
            /*
        case kJSCardTypeDinersClubCarteBlanche:
            regex = @"^30[0-5][0-9]{0,}$";
            break;
        case kJSCardTypeDinersClubEnRoute:
            regex = @"^2((014)|(149))[0-9]{0,}$";
            break;
        case kJSCardTypeDinersInternational:
            regex = @"^3((0[0-5])|((09)|6|8|9))[0-9]{0,}$";
            break;
        case kJSCardTypeDinersUnitedStatesCanada:
            regex = @"^5(4|5)[0-9]{0,}$";
            break;
             */
        case kJSCardTypeDiscover:
            regex = @"^6((011)|((22((12[6-9])|(1[3-9][0-9])|([2-8][0-9]{2})|(9[0-2][0-5])))|4[4-9]|5))[0-9]{0,}$";
            break;
        case kJSCardTypeInstaPayment:
            regex = @"^63[7-9][0-9]{0,}$";
            break;
        case kJSCardTypeInterPayment:
            regex = @"^636[0-9]{0,}$";
            break;
        case kJSCardTypeJCB:
            regex = @"^35((2[8-9])|([3-8][0-9]))[0-9]{0,}$";
            break;
        case kJSCardTypeLaser:
            regex = @"^6((304)|7((0(6|9))|71))[0-9]{0,}$";
            break;
        case kJSCardTypeMaestro:
            // Starts with 50 or (56-59 or 60-69) followed by numbers from 0-9 to any length
            regex = @"^((50)|((5[6-9])|(6[0-9])))[0-9]{0,}$";
            break;
        case kJSCardTypeMasterCard:
            regex = @"^((((222[1-9])|(22[3-9][0-9])|(2[3-6][0-9][0-9])|(27[0-1][0-9])|2720)|(5[1-5]))[0-9]{0,})|(5(4|5)[0-9]{0,})$";
            break;
        case kJSCardTypeSolo:
            regex = @"^6(334|767)[0-9]{0,}$";
            break;
        case kJSCardTypeSwitch:
            regex = @"^((49(03|05|11|36))|(564182)|(6((33(110|3))|759)))[0-9]{0,}$";
            break;
        case kJSCardTypeUATP:
            regex = @"^1[0-9]{0,}$";
            break;
        case kJSCardTypeVisa:
            regex = @"^4[0-9]{0,}$";
        default:
            break;
    }
    return [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
}

- (BOOL)isValidCardLengthWithType:(JSCardType)type {
    if (type == kJSCardTypeAmericanExpress) return [self length] == 15;
    if (type == kJSCardTypeBankcard) return [self length] == 16;
    if (type == kJSCardTypeChinaUnionPay) return [self length] >= 16 && [self length] <= 19;
    if (type == kJSCardTypeDankort) return [self length] == 16;
    //    if (type == kJSCardTypeDinersClubCarteBlanche) return [cardNumber length] == 14;
//    if (type == kJSCardTypeDinersClubEnRoute) return [self length] == 15;
//    if (type == kJSCardTypeDinersInternational) return [self length] == 14;
//    if (type == kJSCardTypeDinersUnitedStatesCanada) return [self length] == 16;
    if (type == kJSCardTypeDiners) return [self length] >= 14 && [self length] <= 16;
    if (type == kJSCardTypeDiscover) return [self length] == 16 || [self length] == 19;
    if (type == kJSCardTypeInstaPayment) return [self length] == 16;
    if (type == kJSCardTypeInterPayment) return [self length] >= 16 && [self length] <= 19;
    if (type == kJSCardTypeJCB) return [self length] == 16;
    if (type == kJSCardTypeLaser) return [self length] >= 16 && [self length] <= 19;
    if (type == kJSCardTypeMaestro) return [self length] >= 12 && [self length] <= 19;
    if (type == kJSCardTypeMasterCard) return [self length] == 16;
    if (type == kJSCardTypeSolo) return [self length] == 16 || [self length] == 18 || [self length] == 19;
    if (type == kJSCardTypeSwitch) return [self length] == 16 || [self length] == 18 || [self length] == 19;
    if (type == kJSCardTypeUATP) return [self length] == 15;
    if (type == kJSCardTypeVisa) return [self length] == 13 || [self length] == 16 || [self length] == 19;
    return kJSCardTypeInvalid;
}

/*
 Removes non-digits from the string, decrementing `cursorPosition` as
 appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 and a cursor position of `8`, the cursor position will be changed to
 `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigitsAndPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i = 0; i < [self length]; i++) {
        unichar characterToAdd = [self characterAtIndex:i];
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        } else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

- (NSString *)lastXCharacters:(int)x {
    return [self substringFromIndex:MAX((int)[self length] - x, 0)]; //in case string is less than 4 characters long.
}

- (NSString *)protectedCardString {
    NSMutableString *cc = [NSMutableString stringWithString:[self lastXCharacters:4]];
    for (int i = 0; i < 12; i++) {
        [cc insertString:kJSTextFieldCircleCharacter atIndex:0];
    }
    return cc;
}

/*
 Inserts spaces into the string to format it as a credit card number,
 incrementing `cursorPosition` as appropriate so that, for instance, if we
 pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 will be changed to `8` (keeping it between the '2' and the '3' after the
 spaces are added).
 */
- (NSString *)insertSpacesEveryXDigits:(NSInteger)digits preserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < [self length]; i++) {
        if (i > 0 && i % digits == 0) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [self characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}

- (NSString *)insertSpacesForCardType:(JSCardType)card preserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < [self length]; i++) {
        if (i > 0 && i % 4 == 0) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [self characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}

@end
