//
//  PostViewController.h
//  RSScraper
//
//  Created by Rose CW on 9/9/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface PostViewController : UIViewController @property (strong)NSDictionary* rssItem;
@property (strong)NSString* longDescription;


@property (strong, nonatomic) IBOutlet UIImageView *screenShotImageView;
@property (strong, nonatomic) UIImage *screenShotImage;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
- (IBAction)showListViewController;

- (void)slideThenHide;
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer ;

@end




