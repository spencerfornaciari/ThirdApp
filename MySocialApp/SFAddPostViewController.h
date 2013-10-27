//
//  SFAddPostViewController.h
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAddPostViewController.h"
#import "SFPostModel.h"

@protocol SFAddItemViewControllerDelegate <NSObject>
-(void)addPost:(SFPostModel *)addNewPost;
@end

@interface SFAddPostViewController : UIViewController

@property (weak, nonatomic) id <SFAddItemViewControllerDelegate> delegateItem;

@property (weak, nonatomic) IBOutlet UITextField *submitUserName;
@property (weak, nonatomic) IBOutlet UITextField *submitTitle;
@property (weak, nonatomic) IBOutlet UITextField *submitContent;

@property (strong) NSManagedObject *post;

-(IBAction)saveButton:(id)sender;

@end
