//
//  SFPostModel.h
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFPostModel : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content;
@property (nonatomic) NSDate *timeStamp;

@end
