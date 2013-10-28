//
//  SFURLPostSession.h
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/28/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFURLPostSession : NSURLSession

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *posts;

-(NSDictionary *)getURLData;
-(void)sendURLData:(NSData *)uploadData;

@end
