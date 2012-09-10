//
//  ContentViewController.h
//  SlideOutNavigationSample
//
//  Created by Nick Harris on 2/3/12.
//  Copyright (c) 2012 Sepia Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (strong, atomic) IBOutlet UIImageView *logoImageView;

- (IBAction)slideMenuButtonTouched;

@end
