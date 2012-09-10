//
//  AppDelegate.h
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PostViewController.h"
#import "ListViewController.h"
#import "ContentViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) ContentViewController *contentViewController;
@property (strong, nonatomic) PostViewController *menuViewController;
@property (strong, nonatomic) UIWindow *window;
-(void)showSideMenu;
-(void)hideSideMenu;
@end
