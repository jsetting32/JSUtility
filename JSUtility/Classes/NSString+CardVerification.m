//
//  NSString+CardVerification.m
//  Pods
//
//  Created by John Setting on 10/12/16.
//
//

#import "NSString+CardVerification.h"

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

+ (JSCardType)cardType:(NSString *)cardNumber {
    NSArray *types = @[@(kJSCardTypeAmericanExpress),
                       //                       @(kJSCardTypeBankcard),
                       //                       @(kJSCardTypeChinaUnionPay),
                       @(kJSCardTypeDankort),
                       @(kJSCardTypeDinersClubCarteBlanche),
                       //                       @(kJSCardTypeDinersClubEnRoute),
                       @(kJSCardTypeDinersInternational),
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
        BOOL isCurrentType = [predicate evaluateWithObject:cardNumber];
        if (isCurrentType) {
            type = _type;
            *stop = YES;
        }
    }];
    
    return type;
}

+ (UIImage *)cardImage:(JSCardType)type {
    if (type == kJSCardTypeAmericanExpress) return [UIImage imageNamed:@"amex"];
    if (type == kJSCardTypeBankcard) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeChinaUnionPay) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeDankort) return [UIImage imageNamed:@"dankort"];
    if (type == kJSCardTypeDinersClubCarteBlanche) return [UIImage imageNamed:@"diners"];
    if (type == kJSCardTypeDinersClubEnRoute) return [UIImage imageNamed:@"diners"];
    if (type == kJSCardTypeDinersInternational) return [UIImage imageNamed:@"diners"];
    if (type == kJSCardTypeDinersUnitedStatesCanada) return [UIImage imageNamed:@"diners"];
    if (type == kJSCardTypeDiscover) return [UIImage imageNamed:@"discover"];
    if (type == kJSCardTypeInstaPayment) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeInterPayment) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeJCB) return [UIImage imageNamed:@"jcb"];
    if (type == kJSCardTypeLaser) return [UIImage imageNamed:@"laster"];
    if (type == kJSCardTypeMaestro) return [UIImage imageNamed:@"maestro"];
    if (type == kJSCardTypeMasterCard) return [UIImage imageNamed:@"mastercard"];
    if (type == kJSCardTypeSolo) return [UIImage imageNamed:@"solo"];
    if (type == kJSCardTypeSwitch) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeUATP) return [UIImage imageNamed:@"credit"];
    if (type == kJSCardTypeVisa) return [UIImage imageNamed:@"visa"];
    return [UIImage imageNamed:@"credit"];
}

+ (NSPredicate *)predicateForType:(JSCardType)type {
    if (type == kJSCardTypeInvalid) {
        return nil;
    }
    
    // Regex Number Ranges : http://stackoverflow.com/questions/676467/how-to-match-numbers-between-x-and-y-with-regexp
    // Regex Cheat Sheet : http://www.rexegg.com/regex-quickstart.html
    
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
        case kJSCardTypeDankort:
            regex = @"^4((175)|(571))[0-9]{0,}$";
            break;
        case kJSCardTypeDinersClubCarteBlanche:
            regex = @"^30[0-5][0-9]{0,}$";
            break;
        case kJSCardTypeDinersClubEnRoute:
            regex = @"^2((014)|(149))[0-9]{0,}$";
            break;
        case kJSCardTypeDinersInternational:
            regex = @"^3((0[0-5])|((09)|6|8|9))[0-9]{0,}$";
            //            regex = @"^3(?:0[0-5]|[68][0-9])[0-9]{4,}$";
            break;
        case kJSCardTypeDinersUnitedStatesCanada:
            regex = @"^5(4|5)[0-9]{0,}$";
            break;
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
            regex = @"^((50)|((5[6-9])|(6[0-9])))[0-9]{0,}$";
            break;
        case kJSCardTypeMasterCard:
            regex = @"^(((222[1-9])|(22[3-9][0-9])|(2[3-6][0-9][0-9])|(27[0-1][0-9])|2720)|(5[1-5]))[0-9]{0,}$";
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
    if (type == kJSCardTypeDinersClubEnRoute) return [self length] == 15;
    if (type == kJSCardTypeDinersInternational) return [self length] == 14;
    if (type == kJSCardTypeDinersUnitedStatesCanada) return [self length] == 16;
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


@end
