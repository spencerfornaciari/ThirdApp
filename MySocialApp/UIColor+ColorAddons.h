//
//  UIColor+ColorAddons.h
//  ColorTest
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorAddons)

+(UIColor *)getRandomColor;
+(UIColor *)lightenOldColor:(UIColor *)oldColor;

@end
