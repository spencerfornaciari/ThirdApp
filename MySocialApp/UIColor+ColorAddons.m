//
//  UIColor+ColorAddons.m
//  ColorTest
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "UIColor+ColorAddons.h"
#import <stdlib.h>

@implementation UIColor (ColorAddons)

//A class function to get a random color

+(UIColor *)getRandomColor
{
    float red = arc4random_uniform(255)/255.0;
    float blue = arc4random_uniform(255)/255.0;
    float green =  arc4random_uniform(255)/255.0;
    
    UIColor *randomColor = [UIColor colorWithRed:(red) green:(green) blue:(blue) alpha:1] ;

    return randomColor;
}

//A class function that returns a lighter color when provided a UI Color

+(UIColor *)lightenOldColor:(UIColor *)oldColor
{
    float oldRed, oldGreen, oldBlue, oldAlpha;
    
    [oldColor getRed:&oldRed green:&oldGreen blue:&oldBlue alpha:&oldAlpha];
    
    if (oldRed < 1.1 && oldGreen < 1.1 && oldBlue < 1.1) {
        UIColor *newColor = [[UIColor alloc] initWithRed:(oldRed + .1) green:(oldGreen + .1) blue:(oldBlue + +.1) alpha:oldAlpha];
        return newColor;
    } else {
        return oldColor;
    }
}

@end
