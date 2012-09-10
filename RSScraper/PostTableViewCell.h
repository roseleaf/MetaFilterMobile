//
//  PostTableViewCell.h
//  RSScraper
//
//  Created by Rose CW on 9/9/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell {
    UIImageView* screenShotImageView;
}
@property(nonatomic,retain)UILabel* primaryLabel;
@property(nonatomic, retain)UILabel* postedByLabel;
@end
