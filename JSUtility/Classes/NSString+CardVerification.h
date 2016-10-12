//
//  NSString+CardVerification.h
//  Pods
//
//  Created by John Setting on 10/12/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSCardType) {
    kJSCardTypeAmericanExpress,
    kJSCardTypeBankcard,                /* Invalid */
    kJSCardTypeChinaUnionPay,
    kJSCardTypeDankort,
    kJSCardTypeDinersClubCarteBlanche,
    kJSCardTypeDinersClubEnRoute,       /* Invalid */
    kJSCardTypeDinersInternational,
    kJSCardTypeDinersUnitedStatesCanada,
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
+ (JSCardType)cardType:(NSString *)cardNumber;
+ (UIImage *)cardImage:(JSCardType)type;
+ (NSPredicate *)predicateForType:(JSCardType)type;
- (BOOL)isValidCardLengthWithType:(JSCardType)type;
@end
