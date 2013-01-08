//
//  IAPAppDelegate.m
//  iOSKW IAP Test 1
//
//  Created by Christina Moulton on 2013-01-08.
//  Copyright (c) 2013 Teak Mobile Inc. All rights reserved.
//

#import "IAPAppDelegate.h"
#import "MKStoreManager.h"

@implementation IAPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [MKStoreManager sharedManager];
  return YES;
}

@end
