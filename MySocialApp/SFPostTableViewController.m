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
    
    
    
    NSDictionary *createJSON = [NSDictionary dictionaryWithObjectsAndKeys:@"Spencer Test 3", @"username", @"New Post 3", @"title", @"Let's go for three", @"content", nil];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:createJSON
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
   
    //SFURLPostSession *newPost = [[SFURLPostSession alloc] init];
    //NSDictionary *newDict = [newPost getURLData];
    
    //[newPost sendURLData:jsonData];
    
    
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
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    self.posts = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    

    if (self.colorArray.count == 0) {
        
        self.colorArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < self.posts.count ; (i = i + 1))
        {
                  [self.colorArray insertObject:[UIColor getRandomColor] atIndex:i];
                   NSLog(@"%@", self.colorArray[i]);
        }
        
    }
    
    [self.tableView reloadData];
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
    if ([[segue identifier] isEqualToString:@"EditPostSegue"])
    {
        NSManagedObject *selectedPost = [self.posts objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SFEditPostViewController *destViewController = segue.destinationViewController;
        destViewController.editPost = selectedPost;
        destViewController.delegateEdit = self;
    }
    
    if ([[segue identifier] isEqualToString:@"AddPostSegue"])
    {
        SFAddPostViewController *destViewController = segue.destinationViewController;
        destViewController.delegateItem = self;
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
    [self.colorArray insertObject:[UIColor getRandomColor] atIndex:0];
}

-(void)updatePost:(SFPostModel *)editOldPost forObject:(NSManagedObject *)oldObject
{    
    [oldObject setValue:editOldPost.userName forKey:@"userName"];
    [oldObject setValue:editOldPost.title forKey:@"title"];
    [oldObject setValue:editOldPost.content forKey:@"content"];
    [oldObject setValue:editOldPost.timeStamp forKey:@"timeStamp"];
    
}

+(void)sendURLData:(NSData *)uploadData
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
