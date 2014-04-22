//
//  AdmodInterstatial.m
//  AdmodsANE
//
//  Created by rect on 14-4-22.
//  Copyright (c) 2014年 rect. All rights reserved.
//

#import "AdmodInterstatial.h"
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"
#import "GADRequest.h"

@interface AdmodInterstatial ()
@property FREContext context;
@property (retain) UIWindow* win;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic)  NSString* admodKeyID;
@end

@implementation AdmodInterstatial

@synthesize context,win,interstitial,admodKeyID;

/*
 * init the adobe air ctx
 *
 */
- (id)initWithContext:(FREContext)extensionContext
{
    NSLog(@"init context");
    
    self = [super init];
    if( self )
    {
        NSLog(@"context not null");
        context = extensionContext;
        win = [UIApplication sharedApplication].keyWindow;
        
    }
    return self;
}
/*
 * the function use to callback
 *
 */
-(void)sendMsgToAs:(NSString *  )code level:(NSString * )level {
    
    NSLog(@"code = %@,level = %@",code,level);
    FREDispatchStatusEventAsync( context,
                                (const uint8_t *)[code UTF8String],
                                (const uint8_t *)[level UTF8String]);
}

-(void)setAdmodKeyID:(NSString*)key
{
    admodKeyID = [NSString stringWithString:key];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //self.loadingSpinner.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2,
                                            // self.loadingSpinner.center.y);
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    //[self.loadingSpinner stopAnimating];
    //self.showInterstitialButton.enabled = YES;
    [self showInterstitial];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    //[self.loadingSpinner stopAnimating];
    // Alert the error.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GADRequestError"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"Drat"
                                          otherButtonTitles:nil];
    [alert show];
    
    //self.showInterstitialButton.enabled = NO;
}

#pragma mark GADRequest implementation

- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as well as any devices
    // you want to receive test ads.
    request.testDevices = @[
                            // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
                            // the console when the app is launched.
                            GAD_SIMULATOR_ID
                            ];
    return request;
}

#pragma mark Insterstitial button actions

- (void)loadInterstitial {
    // Create a new GADInterstitial each time.  A GADInterstitial will only show one request in its
    // lifetime. The property will release the old one and set the new one.
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    
    // Note: Edit SampleConstants.h to update kSampleAdUnitId with your interstitial ad unit id.
    self.interstitial.adUnitID = admodKeyID;
    [self.interstitial loadRequest:[self request]];
    //[self.loadingSpinner startAnimating];
    
    //self.showInterstitialButton.enabled = NO;
}

- (void)showInterstitial{
    //self.showInterstitialButton.enabled = NO;
    
    // Show the interstitial.
    [self.interstitial presentFromRootViewController:win.rootViewController];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
