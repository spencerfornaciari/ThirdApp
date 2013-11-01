//
//  SFEditPostViewController.m
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/27/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFEditPostViewController.h"

@interface SFEditPostViewController ()

@end

@implementation SFEditPostViewController

@synthesize delegateEdit;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.editPost) {
        [self.editUserName setText:[self.editPost valueForKey:@"userName"]];
        [self.editTitle setText:[self.editPost valueForKey:@"title"]];
        [self.editContent setText:[self.editPost valueForKey:@"content"]];
    }
    
//    if (self.editID) {
//        [self.editUserName setText:[self.editDictionary objectForKey:@"userName"]];
//        [self.editTitle setText:[self.editDictionary objectForKey:@"title"]];
//        [self.editContent setText:[self.editDictionary objectForKey:@"content"]];
//    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveEditButton:(id)sender
{
    SFPostModel *updatedPostItem = [[SFPostModel alloc] init];
    updatedPostItem.userName = self.editUserName.text;
    updatedPostItem.title = self.editTitle.text;
    updatedPostItem.content = self.editContent.text;
    updatedPostItem.timeStamp = [NSDate date];
    
    //Update JSON item in feed
    
//    NSDictionary *updateJSONToSend = [[NSDictionary alloc] initWithObjectsAndKeys:self.editUserName.text, @"userName",                                                                                                           self.editTitle.text, @"title", self.editContent.text, @"content", nil];
//   
//    
//  [self updateJSON:updateJSONToSend];
    
    [self.delegateEdit updatePost:updatedPostItem forObject:self.editPost];
    [self.navigationController popViewControllerAnimated:YES];
}


//Update JSON Post from post ID
-(void)updateJSON:(NSDictionary *)updateDictionary
{
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:updateDictionary
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *defaultURL = @"http://cfpost.minddiaper.com/post/update/";
    NSString *newURL = [NSString stringWithFormat:@"%@%@", defaultURL, self.editID];
    NSLog(@"%@", newURL);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *sendURL = [NSURL URLWithString:newURL];
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:sendURL];
    [newRequest setHTTPMethod:@"POST"];
    [newRequest setHTTPBody:jsonData];
    [newRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:newRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    [uploadTask resume];
}

@end
