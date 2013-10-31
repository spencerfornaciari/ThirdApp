//
//  SFAddPostViewController.m
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFAddPostViewController.h"

@interface SFAddPostViewController ()

@end

@implementation SFAddPostViewController


@synthesize post;
@synthesize delegateItem;

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
	// Do any additional setup after loading the view.
    if (self.post) {
        [self.submitUserName setText:[self.post valueForKey:@"userName"]];
        [self.submitTitle setText:[self.post valueForKey:@"title"]];
        [self.submitContent setText:[self.post valueForKey:@"content"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender
{    
//
      //Save to Core Data
    SFPostModel *newPostItem = [[SFPostModel alloc] init];
    newPostItem.userName = self.submitUserName.text;
    newPostItem.title = self.submitTitle.text;
    newPostItem.content = self.submitContent.text;
    newPostItem.timeStamp = [NSDate date];
    
    [self.delegateItem addPost:newPostItem];

    
    
    //Save to JSON
//    NSDictionary *setJSONToSend = [[NSDictionary alloc] initWithObjectsAndKeys:self.submitUserName.text, @"userName",
//                                                                                self.submitTitle.text, @"title",
//                                                                                self.submitContent.text, @"content", nil];
//    NSLog(@"%@", setJSONToSend);
//    [self sendJSON:setJSONToSend];
    
    [self.navigationController popViewControllerAnimated:YES];
}


//Take input and add a post to the JSON feed
-(void)sendJSON:(NSDictionary *)jsonDictionary
{
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *sendURL = [NSURL URLWithString:@"http://cfpost.minddiaper.com/post/create"];
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:sendURL];
    [newRequest setHTTPMethod:@"POST"];
    [newRequest setHTTPBody:jsonData];
    [newRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:newRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    [uploadTask resume];
}


@end
