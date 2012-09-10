//
//  ListViewController.h
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableViewController.h"

@interface ListViewController : PullToRefreshTableViewController
@property (weak, nonatomic) IBOutlet UITableView *rSSTable;
@property(strong)UIImageView* header;
@property (strong, nonatomic) IBOutlet UIImageView *screenShotImageView;
@property (strong, nonatomic) UIImage *screenShotImage;
@end
    