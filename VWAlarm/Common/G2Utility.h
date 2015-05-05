//
//  G2Utility.h
//  VWAlarm
//
//  Created by KIMSEONGTAN on 2015. 4. 15..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

// log
#if DEBUG
#else
#   define NSLog( args... )
#endif

// get delegate
#define SELF_DELEGATE   [[UIApplication sharedApplication] delegate]

// get window
#define SELF_WINDOW     [[[UIApplication sharedApplication] delegate] window]

// device
#define UI_USER_INTERFACE_IDIOM() ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ? [[UIDevice currentDevice] userInterfaceIdiom] : UIUserInterfaceIdiomPhone)
#define IS_PORTRAIT UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) || UIDeviceOrientationIsPortrait(self.interfaceOrientation)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// system version
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// value type
#define ESTABLISH_WEAK_SELF __weak typeof(self) weakSelf = self
#define ESTABLISH_STRONG_SELF __strong typeof(self) strongSelf = weakSelf;

// NSLocalizedString
#define LSTR(s) NSLocalizedString((s), nil)

// userdefaults
#define USERDEFAULTS                        [NSUserDefaults standardUserDefaults]
#define USERDEFAULTS_GET_KEY(key)           [USERDEFAULTS objectForKey:key]
#define USERDEFAULTS_SET_OBJ(key, obj)      [USERDEFAULTS setObject:obj forKey:key]