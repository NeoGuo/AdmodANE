/*
 
 Copyright (c) 2012, DIVIJ KUMAR
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies,
 either expressed or implied, of the FreeBSD Project.
 
 
 */

/*
 * AdmodANE.m
 * AdmodANE
 *
 * Created by rect on 14-4-21.
 * Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
 */

#import "AdmodsANE.h"

/* AdmodANEExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml
 */
void AdmodANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"Entering AdmodANEExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
    
    NSLog(@"Exiting AdmodANEExtInitializer()");
}

/* AdmodANEExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml
 */
void AdmodANEExtFinalizer(void* extData)
{
    NSLog(@"Entering AdmodANEExtFinalizer()");
    
    // Nothing to clean up.
    NSLog(@"Exiting AdmodANEExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] =
    {
        MAP_FUNCTION(isSupported, NULL),
        MAP_FUNCTION(admod_function_banner, NULL),
        MAP_FUNCTION(admod_function_interstitial, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    // init banner plstr
    P_Banner = [[AdmodModBanner alloc] initWithContext:ctx];
    P_Interstatial = [[AdmodInterstatial alloc] initWithContext:ctx];
    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");
    
    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


/* This is a TEST function that is being included as part of this template.
 *
 * Users of this template are expected to change this and add similar functions
 * to be able to call the native functions in the ANE from their ActionScript code
 */
ANE_FUNCTION(isSupported)
{
    NSLog(@"Entering IsSupported()");
    
    FREObject fo;
    
    FREResult aResult = FRENewObjectFromBool(YES, &fo);
    if (aResult == FRE_OK)
    {
        NSLog(@"Result = %d", aResult);
    }
    else
    {
        NSLog(@"Result = %d", aResult);
    }
    
	NSLog(@"Exiting IsSupported()");
	return fo;
}

ANE_FUNCTION(admod_function_banner)
{
    [P_Banner sendMsgToAs:@"AdmodBanner" level:@"begining banner"];
    [P_Banner setAdmodKeyID:getStringFromFREObject(argv[0])];
    [P_Banner viewDidLoad];
    [P_Banner sendMsgToAs:@"AdmodBanner" level:@"end banner"];
	return NULL;
}

ANE_FUNCTION(admod_function_interstitial)
{
    [P_Interstatial sendMsgToAs:@"AdmodInterstatial" level:@"begining Interstatial"];
    [P_Interstatial setAdmodKeyID:getStringFromFREObject(argv[0])];
    [P_Interstatial loadInterstitial];
    [P_Interstatial sendMsgToAs:@"AdmodInterstatial" level:@"end Interstatial"];
	return NULL;
}


// FREObject to int
int getIntFromFreObject(FREObject freObject)
{
    int32_t value;
    FREGetObjectAsInt32(freObject, &value);
    return value;
    
}

/*
 *将FREObject转成NSString
 */
NSString * getStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

BOOL getBoolFormFreObject(FREObject freObject)
{
    uint32_t value;
    FREGetObjectAsBool(freObject,&value);
    return (BOOL)value;
}










