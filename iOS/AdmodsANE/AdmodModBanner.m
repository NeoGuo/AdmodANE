//
//  AdmodModBanner.m
//  AdmodsANE
//
//  Created by rect on 14-4-22.
//  Copyright (c) 2014年 rect. All rights reserved.
//

#import "AdmodModBanner.h"

#import "GADBannerView.h"
#import "GADRequest.h"

@interface AdmodModBanner ()

@property FREContext context;
@property (retain) UIWindow* win;
@property(nonatomic, strong) GADBannerView *adBanner;
@property (nonatomic)  NSString* admodKeyID;
@end

@implementation AdmodModBanner

@synthesize context,win,adBanner,admodKeyID;

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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setAdmodKeyID:(NSString*)key
{
    admodKeyID = [NSString stringWithString:key];
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
	// Do any additional setup after loading the view.
    // Initialize the banner at the bottom of the screen.
    CGPoint origin = CGPointMake(0.0,
                                 self.view.frame.size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    
    // Use predefined GADAdSize constants to define the GADBannerView.
    self.adBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
    
    // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID before compiling.
    NSLog(@"admodKeyID : %@",admodKeyID);
    self.adBanner.adUnitID = admodKeyID;
    self.adBanner.delegate = self;
    self.adBanner.rootViewController = self;
    [win addSubview:self.adBanner];
    [self.adBanner loadRequest:[self request]];
}

#pragma mark GADRequest generation

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

#pragma mark GADBannerViewDelegate implementation

// We've received an ad successfully.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
