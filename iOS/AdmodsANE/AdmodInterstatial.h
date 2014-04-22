//
//  AdmodInterstatial.h
//  AdmodsANE
//
//  Created by rect on 14-4-22.
//  Copyright (c) 2014年 rect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "GADInterstitialDelegate.h"

@class GADInterstitial;
@class GADRequest;

@interface AdmodInterstatial : UIViewController<GADInterstitialDelegate>

- (id)initWithContext:(FREContext)extensionContext;


-(void) sendMsgToAs:(NSString *) code
              level:(NSString * )level;

-(void) setAdmodKeyID:(NSString*)key;

- (GADRequest *)request;
- (void)loadInterstitial;
- (void)showInterstitial;
@end
