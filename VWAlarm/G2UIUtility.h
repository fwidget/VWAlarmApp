
//
//  G2UIUtility.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 5..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#ifndef VWAlarm1_G2UIUtility_h
#define VWAlarm1_G2UIUtility_h
// UI parts
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

// color rgb, rgba
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#endif
