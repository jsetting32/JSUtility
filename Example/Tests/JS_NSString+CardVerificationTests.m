//
//  JS_NSString+CardVerificationTests.m
//  Fora
//
//  Created by John Setting on 1/8/16.
//  Copyright © 2016 Logiciel Inc. All rights reserved.
//

#import <JSUtility/JSUtility.h>
#import <Expecta/Expecta.h>

SpecBegin(CardVerification)

describe(@"CardVerification", ^{
    
    it(@"test american express", ^{
        expect([@"34" cardType]).to.equal(kJSCardTypeAmericanExpress);
        expect([@"37" cardType]).to.equal(kJSCardTypeAmericanExpress);
        
        expect([@"342532" cardType]).to.equal(kJSCardTypeAmericanExpress);
        expect([@"376326" cardType]).to.equal(kJSCardTypeAmericanExpress);
    });
    
    /*
    it(@"test bank card", ^{
        expect([@"5610" cardType]).to.equal(kJSCardTypeBankcard);
        expect([@"560221" cardType]).to.equal(kJSCardTypeBankcard);
        expect([@"560225" cardType]).to.equal(kJSCardTypeBankcard);
        expect([@"560223" cardType]).to.equal(kJSCardTypeBankcard);
    });
    */
    
    it(@"test china union pay", ^{
        expect([@"62" cardType]).to.equal(kJSCardTypeChinaUnionPay);
        
        expect([@"621" cardType]).to.equal(kJSCardTypeChinaUnionPay);
        expect([@"62024" cardType]).to.equal(kJSCardTypeChinaUnionPay);
        expect([@"62114" cardType]).to.equal(kJSCardTypeChinaUnionPay);
    });
    
    it(@"test dankort", ^{
        expect([@"5019" cardType]).to.equal(kJSCardTypeDankort);
        
        expect([@"50190" cardType]).to.equal(kJSCardTypeDankort);
        expect([@"50193" cardType]).to.equal(kJSCardTypeDankort);
    });
    
    it(@"test diners Carte Blanche", ^{
        expect([@"300" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"301" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"305" cardType]).to.equal(kJSCardTypeDiners);
    });
    
    it(@"test diners club en route", ^{
        expect([@"2014" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"2149" cardType]).to.equal(kJSCardTypeDiners);

        expect([@"201442" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"214952" cardType]).to.equal(kJSCardTypeDiners);
    });
    
    it(@"test diners international", ^{
        expect([@"300" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"301" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"302" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"303" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"304" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"305" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"309" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"36" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"38" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"39" cardType]).to.equal(kJSCardTypeDiners);

        expect([@"389" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"36326" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"30214" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"301241" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"300000" cardType]).to.equal(kJSCardTypeDiners);
        expect([@"39024" cardType]).to.equal(kJSCardTypeDiners);
    });
    
    it(@"test diners UnitedStates Canada", ^{
        expect([@"54" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"55" cardType]).to.equal(kJSCardTypeMasterCard);
    });
    
    it(@"test discover", ^{
        expect([@"6011" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"622126" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"622925" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"622200" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"644" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"645" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"649" cardType]).to.equal(kJSCardTypeDiscover);
        expect([@"65" cardType]).to.equal(kJSCardTypeDiscover);
    });
    
    it(@"test insta payment", ^{
        expect([@"637" cardType]).to.equal(kJSCardTypeInstaPayment);
        expect([@"638" cardType]).to.equal(kJSCardTypeInstaPayment);
        expect([@"639" cardType]).to.equal(kJSCardTypeInstaPayment);
    });

    it(@"test inter payment", ^{
        expect([@"636" cardType]).to.equal(kJSCardTypeInterPayment);
    });

    it(@"test jcb", ^{
        expect([@"3528" cardType]).to.equal(kJSCardTypeJCB);
        expect([@"3582" cardType]).to.equal(kJSCardTypeJCB);
        expect([@"3589" cardType]).to.equal(kJSCardTypeJCB);
    });

    /*
    it(@"test laser", ^{
        expect([@"6304" cardType]).to.equal(kJSCardTypeLaser);
        expect([@"6706" cardType]).to.equal(kJSCardTypeLaser);
        expect([@"6771" cardType]).to.equal(kJSCardTypeLaser);
        expect([@"6709" cardType]).to.equal(kJSCardTypeLaser);
    });
    */
    
    it(@"test maestro", ^{
        expect([@"50" cardType]).to.equal(kJSCardTypeMaestro);
        expect([@"56" cardType]).to.equal(kJSCardTypeMaestro);
        expect([@"69" cardType]).to.equal(kJSCardTypeMaestro);
        expect([@"60" cardType]).to.equal(kJSCardTypeMaestro);
    });

    it(@"test mastercard", ^{
        expect([@"2221" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"2720" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"2500" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"51" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"52" cardType]).to.equal(kJSCardTypeMasterCard);
        expect([@"55" cardType]).to.equal(kJSCardTypeMasterCard);
    });

    /*
    it(@"test solo", ^{
        expect([@"6334" cardType]).to.equal(kJSCardTypeSolo);
        expect([@"6767" cardType]).to.equal(kJSCardTypeSolo);
    });
    */
    
    /*
    it(@"test switch", ^{
        expect([@"4903" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"4905" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"4911" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"4936" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"564182" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"633110" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"6333" cardType]).to.equal(kJSCardTypeSwitch);
        expect([@"6759" cardType]).to.equal(kJSCardTypeSwitch);
    });
    */

    it(@"test uatp", ^{
        expect([@"1111" cardType]).to.equal(kJSCardTypeUATP);
        expect([@"1234" cardType]).to.equal(kJSCardTypeUATP);
    });

    it(@"test visa", ^{
        expect([@"4111" cardType]).to.equal(kJSCardTypeVisa);
        expect([@"4465" cardType]).to.equal(kJSCardTypeVisa);
    });

});

SpecEnd
