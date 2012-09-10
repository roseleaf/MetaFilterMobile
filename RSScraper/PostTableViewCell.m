//
//  PostTableViewCell.m
//  RSScraper
//
//  Created by Rose CW on 9/9/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        self.textLabel.textAlignment = UITextAlignmentLeft;
    
        self.primaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 240, 91)];
        self.primaryLabel.numberOfLines = 5;
        self.primaryLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.postedByLabel = [UILabel new];
        [self.contentView addSubview:self.postedByLabel];
        //CGSize*textLabelSize = CGSizeMake(240, 91);
        [self.contentView addSubview:self.primaryLabel];
    }
    return self;
}





- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
        
    frame= CGRectMake(boundsX+100 ,10, 200, 35);
    //self.primaryLabel.frame = frame;
    self.primaryLabel.backgroundColor = [UIColor clearColor];
    self.primaryLabel.textColor = [UIColor blackColor];
    
    frame= CGRectMake(10, 120, 300, 16);
    self.postedByLabel.frame = frame;
    self.postedByLabel.backgroundColor = [UIColor clearColor];
    self.postedByLabel.textColor = [UIColor lightGrayColor];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
