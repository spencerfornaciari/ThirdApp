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
    
    [self.delegateEdit updatePost:updatedPostItem forObject:self.editPost];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
