//
//  IAPViewController.m
//  iOSKW IAP Test 1
//
//  Created by Christina Moulton on 2013-01-08.
//  Copyright (c) 2013 Teak Mobile Inc. All rights reserved.
//

#import "IAPViewController.h"
#import "MKStoreManager.h"

#define PRODUCT_1_ID @"com.teakmobile.ioskw.inappdemo.test1.product1"

@implementation IAPViewController

- (IBAction)purchaseProduct1
{
  [[MKStoreManager sharedManager] buyFeature:PRODUCT_1_ID
                                  onComplete:^(NSString* purchasedFeature,
                                               NSData* purchasedReceipt,
                                               NSArray* downloads) {
                                    NSLog(@"Purchased: %@", purchasedFeature);
                                    // provide product to the user
                                  } onCancelled:^ {
                                    NSLog(@"User Cancelled Transaction");
                                  }];
}

- (IBAction)showIsProduct1Purchased
{
  NSString *title;
  if ([MKStoreManager isFeaturePurchased:PRODUCT_1_ID])
  {
    title = @"Product 1 is purchased";
  }
  else
  {
    title = @"Product 1 is not purchased";
  }
  UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Product 1"
                                                      message:title
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  [alertview show];
}

@end
