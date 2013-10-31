//
//  SFPostTableViewController.h
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPostTableViewCell.h"
#import "SFAddPostViewController.h"
#import "SFEditPostViewController.h"
#import "UIColor+ColorAddons.h"

@interface SFPostTableViewController : UITableViewController <SFAddItemViewControllerDelegate, SFEditItemViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableArray *colorArray;

-(void)getURLData;

@end
