//
//  NSString+CardVerification.h
//  JSUtility
//
//  Created by John Setting on 8/30/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSCardType) {
    kJSCardTypeAmericanExpress,
    kJSCardTypeBankcard,                /* Invalid */
    kJSCardTypeChinaUnionPay,
    kJSCardTypeDankort,
    kJSCardTypeDiners,
//    kJSCardTypeDinersClubCarteBlanche,
//    kJSCardTypeDinersClubEnRoute,       /* Invalid */
//    kJSCardTypeDinersInternational,
//    kJSCardTypeDinersUnitedStatesCanada,
    kJSCardTypeDiscover,
    kJSCardTypeInstaPayment,
    kJSCardTypeInterPayment,
    kJSCardTypeJCB,
    kJSCardTypeLaser,                   /* Invalid */
    kJSCardTypeMaestro,
    kJSCardTypeMasterCard,
    kJSCardTypeSolo,                    /* Invalid */
    kJSCardTypeSwitch,                  /* Invalid */
    kJSCardTypeUATP,
    kJSCardTypeVisa,
    kJSCardTypeInvalid
};

@interface NSString(CardVerification)
- (BOOL)luhnCheck;
- (BOOL)isCardValidWithType:(JSCardType)type;
- (BOOL)CVVCheckWithType:(JSCardType)type;
- (JSCardType)cardType;
+ (UIImage *)cardImage:(JSCardType)type;
+ (NSPredicate *)predicateForType:(JSCardType)type;
- (BOOL)isValidCardLengthWithType:(JSCardType)type;
- (NSString *)removeNonDigitsAndPreserveCursorPosition:(NSUInteger *)cursorPosition;
- (NSString *)insertSpacesForCardType:(JSCardType)card preserveCursorPosition:(NSUInteger *)cursorPosition;
- (NSString *)insertSpacesEveryXDigits:(NSInteger)digits preserveCursorPosition:(NSUInteger *)cursorPosition;
@end
