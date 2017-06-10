//
//  impl.m
//  CLocalAuthentication
//
//  Created by Shawn Anastasio on 6/9/17.
//  Copyright © 2017 Shawn Anastasio. Licensed under the terms of the GNU GPL v3.

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef enum {
    kTouchIDResultNone,
    kTouchIDResultAllowed,
    kTouchIDResultFailed
} TouchIDResult;

bool supports_touchid(void) {
    LAContext *context = [[LAContext alloc] init];
    const BOOL can_authenticate = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    return can_authenticate;
}

bool authenticate_user_touchid(char *reason) {
    LAContext *context = [[LAContext alloc] init];
    __block TouchIDResult result = kTouchIDResultNone;
    
    // Convert the user's given reason string to an NSString
    NSString *NSReasonString = [NSString stringWithUTF8String:reason];
    
    // Authenticate using TouchID w/ the given reason
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSReasonString
                      reply:^(BOOL success, NSError *error) {
        result = success ? kTouchIDResultAllowed : kTouchIDResultFailed;
        CFRunLoopWakeUp(CFRunLoopGetCurrent());
    }];
    
    while (result == kTouchIDResultNone)
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
    
    return result == kTouchIDResultAllowed;
}
