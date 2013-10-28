//
//  SFURLPostSession.m
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/28/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFURLPostSession.h"

@implementation SFURLPostSession

-(NSDictionary *)getURLData
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    [[delegateFreeSession dataTaskWithURL: [NSURL URLWithString: @"http://blog.teamtreehouse.com/api/get_recent_summary/"]
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            self.posts = [self.dictionary objectForKey:@"posts"];
                            NSLog(@"%@", self.posts);
                            
                        }] resume];
    return self.dictionary;
    
}

-(void)sendURLData:(NSData *)uploadData
{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *sendURL = [NSURL URLWithString:@"http://cfpost.minddiaper.com/post/create"];
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:sendURL];
    [newRequest setHTTPMethod:@"POST"];
    [newRequest setHTTPBody:uploadData];
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:newRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    [uploadTask resume];
}

@end
