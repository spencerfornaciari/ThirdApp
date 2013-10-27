//
//  SFEditPostViewController.h
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/27/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPostModel.h"

@protocol SFEditItemViewControllerDelegate <NSObject>
-(void)updatePost:(SFPostModel *)editOldPost forObject:(NSManagedObject *)oldObject;
@end

@interface SFEditPostViewController : UIViewController

@property (weak, nonatomic) id <SFEditItemViewControllerDelegate> delegateEdit;

@property (weak, nonatomic) IBOutlet UITextField *editUserName;
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextField *editContent;

@property (strong) NSManagedObject *editPost;

-(IBAction)saveEditButton:(id)sender;

@end
