//
//  SFPostTableViewController.m
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFPostTableViewController.h"

@interface SFPostTableViewController ()

@end

@implementation SFPostTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colorArray = [[NSMutableArray alloc] init];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PostCoreData"];
    self.posts = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
    for (int i = 0; i < self.posts.count ; (i = i + 1))
    {
        [self.colorArray addObject:[UIColor getRandomColor]];
        NSLog(@"%d", i);
        NSLog(@"%@", self.colorArray[i]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SFPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *post = [self.posts objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a 'on' MM/dd/yyyy"];
    NSString *postDate = [dateFormatter stringFromDate:[post valueForKey:@"timeStamp"]];
    
    
    cell.userNameLabel.text = [post valueForKey:@"userName"];
    cell.titleLabel.text = [post valueForKey:@"title"];
    cell.contentLabel.text = [post valueForKey:@"content"];
    cell.timeStampLabel.text = postDate;
    
   cell.backgroundColor = self.colorArray[indexPath.row];
    
    
    //[cell.textLabel setText:[NSString stringWithFormat:@"%@", [post valueForKey:@"userName"]]];
    //[cell.detailTextLabel setText:[post valueForKey:@"title"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditPostSegue"]) {
        NSManagedObject *selectedPost = [self.posts objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SFAddPostViewController *destViewController = segue.destinationViewController;
        destViewController.post = selectedPost;
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.posts objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.posts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)addPost:(SFPostModel *)addNewPost
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"PostCoreData" inManagedObjectContext:context];
    [newObject setValue:addNewPost.userName forKey:@"userName"];
    [newObject setValue:addNewPost.title forKey:@"title"];
    [newObject setValue:addNewPost.content forKey:@"content"];
    [newObject setValue:addNewPost.timeStamp forKey:@"timeStamp"];
    
}

-(SFPostModel *)editPost:(SFPostModel *)editOldPost
{
    return nil;
}

/*-(void)addPostToList:(SFPost *)addSFPost
 {
 
 PFObject *newSFPost = [PFObject objectWithClassName:@"PostObject"];
 newSFPost[@"userName"] = addSFPost.userName;
 newSFPost[@"title"] = addSFPost.title;
 newSFPost[@"content"] = addSFPost.content;
 [self.time insertObject:addSFPost.timeStamp atIndex:0];
 [newSFPost saveInBackground];
 
 
 [self.posts insertObject:newSFPost atIndex:0];
 
 [self.tableView reloadData];
 
 }*/

@end
