//
//  AppDelegate.h
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ListViewController.h"
#import "ContentViewController.h"
#import "PostViewController.h"

#define app_delegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@class PostViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) ListViewController *contentViewController;
@property (strong, nonatomic) PostViewController* postViewController;

@property (strong, nonatomic) UIWindow *window;
-(void)showSideMenuWithView:(PostViewController*)view;
-(void)hideSideMenu;
@end
