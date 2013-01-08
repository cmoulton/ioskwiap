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

- (void)viewWillAppear:(BOOL)animated
{
  [self updateStatusDisplay];
}

- (IBAction)purchaseProduct1
{
  [[MKStoreManager sharedManager] buyFeature:PRODUCT_1_ID
                                  onComplete:^(NSString* purchasedFeature,
                                               NSData* purchasedReceipt,
                                               NSArray* downloads) {
                                    NSLog(@"Purchased: %@", purchasedFeature);
                                    // provide product to the user
                                    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Product 1"
                                                                                        message:@"Thanks for purchasing product 1"
                                                                                       delegate:nil
                                                                              cancelButtonTitle:@"OK"
                                                                              otherButtonTitles:nil];
                                    [alertview show];
                                    self.statusLabel.text = @"Purchased Product 1";
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
  [self updateStatusDisplay];
  UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Product 1"
                                                      message:title
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  [alertview show];
}

- (IBAction)showProduct1Info {
  NSLog(@"Prices:\n%@", [[MKStoreManager sharedManager] pricesDictionary]);
  NSLog(@"POD:\n%@", [[MKStoreManager sharedManager] purchasableObjectsDescription]);
  NSLog(@"PO:\n%@", [[MKStoreManager sharedManager] purchasableObjects]);
  
  NSString *message;
  if (([[MKStoreManager sharedManager] purchasableObjects] == nil) || [[MKStoreManager sharedManager] purchasableObjects].count == 0)
  {
    message = @"Product 1 not found";
  }
  else
  {
    SKProduct *product1 = [[[MKStoreManager sharedManager] purchasableObjects] objectAtIndex:0];
    if (NO == [product1.productIdentifier isEqualToString:PRODUCT_1_ID])
    {
      message = @"Product 1 not found";
    }
    else
    {
      NSString *price = [[[MKStoreManager sharedManager] pricesDictionary] objectForKey:PRODUCT_1_ID];
      message = [NSString stringWithFormat:@"Title: %@\nDescription: %@\nPrice: %@", product1.localizedTitle, product1.localizedDescription, price];
    }
  }
  UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Product 1"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  [alertview show];
}

- (IBAction)removePreviousPurchases { //just for sandbox testing
  [[MKStoreManager sharedManager] removeAllKeychainData];
}

- (void)updateStatusDisplay
{
  if ([MKStoreManager isFeaturePurchased:PRODUCT_1_ID])
  {
    self.statusLabel.text = @"Purchased Product 1";
  }
  else
  {
    self.statusLabel.text = @"Product 1 not purchased";
  }
}

- (IBAction)restorePurchases
{
  [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^ {
    NSLog(@"restore purchases");
    [self updateStatusDisplay];
  } onError:^(NSError *error) {
    NSLog(@"restore purchases error: %@", error);
  }];
}

@end
