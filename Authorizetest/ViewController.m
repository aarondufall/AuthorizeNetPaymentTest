//
//  ViewController.m
//  Authorizetest
//
//  Created by Heart on 11/11/13.
//  Copyright (c) 2013 BlewsoftTECHNOLOGIES. All rights reserved.
//

#import "ViewController.h"
#import "MobileDeviceLoginRequest.h"
#import "AuthNet.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize sessionToken;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) loginToGateway
{
    
    MobileDeviceLoginRequest *mobileDeviceLoginRequest =
    [MobileDeviceLoginRequest mobileDeviceLoginRequest];
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.name = @"";
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.password = @"";
    
    
    NSLog(@"UIDevice =%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]);
    
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.mobileDeviceId =
    [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    AuthNet *an = [AuthNet getInstance];
    [an setDelegate:self];
    [an mobileDeviceLoginRequest: mobileDeviceLoginRequest];
}


- (void) createTransaction {
    AuthNet *an = [AuthNet getInstance];
    
    [an setDelegate:self];
    
    CreditCardType *creditCardType = [CreditCardType creditCardType];
    creditCardType.cardNumber = @"4111111111111111";
    creditCardType.cardCode = @"100";
    creditCardType.expirationDate = @"1212";
    
    PaymentType *paymentType = [PaymentType paymentType];
    paymentType.creditCard = creditCardType;
    
    ExtendedAmountType *extendedAmountTypeTax = [ExtendedAmountType extendedAmountType];
    extendedAmountTypeTax.amount = @"0";
    extendedAmountTypeTax.name = @"Tax";
    
    ExtendedAmountType *extendedAmountTypeShipping = [ExtendedAmountType extendedAmountType];
    extendedAmountTypeShipping.amount = @"0";
    extendedAmountTypeShipping.name = @"Shipping";
    
    LineItemType *lineItem = [LineItemType lineItem];
    lineItem.itemName = @"Soda";
    lineItem.itemDescription = @"Soda";
    lineItem.itemQuantity = @"1";
    lineItem.itemPrice = @"1.00";
    lineItem.itemID = @"1";
    
    TransactionRequestType *requestType = [TransactionRequestType transactionRequest];
    requestType.lineItems = [NSArray arrayWithObject:lineItem];
    requestType.amount = @"1.00";
    requestType.payment = paymentType;
    requestType.tax = extendedAmountTypeTax;
    requestType.shipping = extendedAmountTypeShipping;
    
    CreateTransactionRequest *request = [CreateTransactionRequest createTransactionRequest];
    request.transactionRequest = requestType;
    request.transactionType = AUTH_ONLY;
    request.anetApiRequest.merchantAuthentication.mobileDeviceId =
    [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
    request.anetApiRequest.merchantAuthentication.sessionToken = sessionToken;
    [an purchaseWithRequest:request];
}

- (void) requestFailed:(AuthNetResponse *)response {
    // Handle a failed request
}

- (void) connectionFailed:(AuthNetResponse *)response {
    // Handle a failed connection
}

- (void) paymentSucceeded:(CreateTransactionResponse *) response {
    // Handle payment success
}

- (void) mobileDeviceLoginSucceeded:(MobileDeviceLoginResponse *)response
{
    sessionToken = response.sessionToken;
    [self createTransaction];
};

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
