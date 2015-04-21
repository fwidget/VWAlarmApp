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

// UI parts
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

// device
#define IS_PORTRAIT UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) || UIDeviceOrientationIsPortrait(self.interfaceOrientation)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// value type
#define ESTABLISH_WEAK_SELF __weak typeof(self) weakSelf = self
#define ESTABLISH_STRONG_SELF __strong typeof(self) strongSelf = weakSelf;

// localized
#define LSTR(s) NSLocalizedString((s), nil)

// color rgb, rgba
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// constraints
#pragma mark - Constraints
#define PREPCONSTRAINTS(VIEW) [VIEW setTranslatesAutoresizingMaskIntoConstraints:NO]
#define CONSTRAIN(PARENT, VIEW, FORMAT) [PARENT addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:(FORMAT) options:0 metrics:nil views:NSDictionaryOfVariableBindings(VIEW)]]
#define CONSTRAIN_VIEWS(PARENT, FORMAT, VIEWBINDINGS) [PARENT addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:(FORMAT) options:0 metrics:nil views:VIEWBINDINGS]]

// Stretch across axis
#define STRETCH_VIEW_H(PARENT, VIEW) CONSTRAIN(PARENT, VIEW, @"H:|["#VIEW"(>=0)]|")
#define STRETCH_VIEW_V(PARENT, VIEW) CONSTRAIN(PARENT, VIEW, @"V:|["#VIEW"(>=0)]|")
#define STRETCH_VIEW(PARENT, VIEW) {STRETCH_VIEW_H(PARENT, VIEW); STRETCH_VIEW_V(PARENT, VIEW);}

// Center along axis
#define CENTER_VIEW_H(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]]
#define CENTER_VIEW_V(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]]
#define CENTER_VIEW(PARENT, VIEW) {CENTER_VIEW_H(PARENT, VIEW); CENTER_VIEW_V(PARENT, VIEW);}

// Align to parent
#define ALIGN_VIEW_LEFT(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]]
#define ALIGN_VIEW_RIGHT(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]]
#define ALIGN_VIEW_TOP(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]]
#define ALIGN_VIEW_BOTTOM(PARENT, VIEW) [PARENT addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute: NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:PARENT attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]]

// Set Size
#define CONSTRAIN_WIDTH(VIEW, WIDTH) CONSTRAIN(VIEW, VIEW, @"H:["#VIEW"(=="#WIDTH")]")
#define CONSTRAIN_HEIGHT(VIEW, HEIGHT) CONSTRAIN(VIEW, VIEW, @"V:["#VIEW"(=="#HEIGHT")]")
#define CONSTRAIN_SIZE(VIEW, HEIGHT, WIDTH) {CONSTRAIN_WIDTH(VIEW, WIDTH); CONSTRAIN_HEIGHT(VIEW, HEIGHT);}

// Set Aspect
#define CONSTRAIN_ASPECT(VIEW, ASPECT) [VIEW addConstraint:[NSLayoutConstraint constraintWithItem:VIEW attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:VIEW attribute:NSLayoutAttributeHeight multiplier:(ASPECT) constant:0.0f]]

