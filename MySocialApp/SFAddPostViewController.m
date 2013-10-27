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
    SFPostModel *newPostItem = [[SFPostModel alloc] init];
    newPostItem.userName = self.submitUserName.text;
    newPostItem.title = self.submitTitle.text;
    newPostItem.content = self.submitContent.text;
    newPostItem.timeStamp = [NSDate date];
    
    [self.delegateItem addPost:newPostItem];
    [self.navigationController popViewControllerAnimated:YES];
}





@end
