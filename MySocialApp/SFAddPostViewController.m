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

- (IBAction)saveButton:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.post) {
        // Update existing device
        [self.post setValue:self.submitUserName.text forKey:@"userName"];
        [self.post setValue:self.submitTitle.text forKey:@"title"];
        [self.post setValue:self.submitContent.text forKey:@"content"];
        [self.post setValue:[NSDate date] forKey:@"timeStamp"];
        
    } else {
        // Create a new device
        NSManagedObject *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"PostCoreData" inManagedObjectContext:context];
        [newPost setValue:self.submitUserName.text forKey:@"userName"];
        [newPost setValue:self.submitTitle.text forKey:@"title"];
        [newPost setValue:self.submitContent.text forKey:@"content"];
        [newPost setValue:[NSDate date] forKey:@"timeStamp"];
        
        
        
        /*SFPostModel *newPostItem;
        newPostItem.userName = self.submitUserName.text;
        newPostItem.title = self.submitTitle.text;
        newPostItem.content = self.submitContent.text;
        newPostItem.timeStamp = [NSDate date];
        
        //[self.delegateItem addPost:newPostItem];*/
        
        //[self.delegate addPost:newPost];
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}





@end
