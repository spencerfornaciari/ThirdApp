//
//  SFPostTableViewCell.m
//  MySocialApp
//
//  Created by Spencer Fornaciari on 10/26/13.
//  Copyright (c) 2013 Spencer Fornaciari. All rights reserved.
//

#import "SFPostTableViewCell.h"

@implementation SFPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLabelValues:(SFPostModel *)post
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a MM/dd/yyyy"];
    //NSString *postDate = [dateFormatter stringFromDate:[post.timeStamp]];
    
    _post = post;
    _userNameLabel.text = _post.userName;
    _titleLabel.text = _post.title;
    _contentLabel.text = _post.content;
    _timeStampLabel.text = [dateFormatter stringFromDate:post.timeStamp]; //postDate;
}

@end
