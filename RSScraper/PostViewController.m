//
//  PostViewController.m
//  RSScraper
//
//  Created by Rose CW on 9/9/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController () <UIGestureRecognizerDelegate>
@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addBackButton];
        self.panGesture = [UIPanGestureRecognizer new];
        [self.panGesture addTarget:self action:@selector(pan:)];
        [self.view addGestureRecognizer:self.panGesture];

        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel* descriptionLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
    descriptionLabel.text = [self.rssItem valueForKey:@"textOnlyDesc"];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.view addSubview:descriptionLabel];
    
    
    // create a UITapGestureRecognizer to detect when the screenshot recieves a single tap
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapScreenShot:)];
    [self.screenShotImageView addGestureRecognizer:self.tapGesture];
    
    // create a UIPanGestureRecognizer to detect when the screenshot is touched and dragged
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    [self.panGesture setMaximumNumberOfTouches:2];
    [self.panGesture setDelegate:self];
    [self.screenShotImageView addGestureRecognizer:self.panGesture];
    
}
-(void)pan:(UIPanGestureRecognizer *)panGuy {
    CGPoint translation = [self.panGesture translationInView:self.view];
    [self.panGesture setTranslation:CGPointMake(0.0, 0.0) inView:self.view];
    
    CGRect boundsToMoveTo = self.view.bounds;
    boundsToMoveTo.origin.x = self.view.bounds.origin.x - translation.x;
    boundsToMoveTo.origin.y = self.view.bounds.origin.y - translation.y;
    
    
    self.view.bounds = boundsToMoveTo;
    [self.view setNeedsDisplay];
}


//-----------------start experiment------
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // when the menu view appears, it will create the illusion that the other view has slide to the side
    // what its actually doing is sliding the screenShotImage passed in off to the side
    // to start this, we always want the image to be the entire screen, so set it there
    [self.screenShotImageView setImage:self.screenShotImage];
    [self.screenShotImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // now we'll animate it across to the right over 0.2 seconds with an Ease In and Out curve
    // this uses blocks to do the animation. Inside the block the frame of the UIImageView has its
    // x value changed to where it will end up with the animation is complete.
    // this animation doesn't require any action when completed so the block is left empty
    [UIView animateWithDuration:3.2 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.screenShotImageView setFrame:CGRectMake(265, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
                     completion:^(BOOL finished){  }];
}

-(void) slideThenHide
{
    // this animates the screenshot back to the left before telling the app delegate to swap out the MenuViewController
    // it tells the app delegate using the completion block of the animation
    [UIView animateWithDuration:5.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.screenShotImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
                     completion:^(BOOL finished){ [app_delegate hideSideMenu]; }];
}



-(IBAction)showListViewController
{
    // this sets the currentViewController on the app_delegate to the expanding view controller
    // then slides the screenshot back over
    [app_delegate setContentViewController:[[ListViewController alloc] init]];
    [self slideThenHide];
}



- (void)singleTapScreenShot:(UITapGestureRecognizer *)gestureRecognizer
{
    // on a single tap of the screenshot, assume the user is done viewing the menu
    // and call the slideThenHide function
    [self slideThenHide];
}


/* The following is from http://blog.shoguniphicus.com/2011/06/15/working-with-uigesturerecognizers-uipangesturerecognizer-uipinchgesturerecognizer/ */

-(void)panGestureMoveAround:(UIPanGestureRecognizer *)gesture;
{
    UIView *piece = [gesture view];
    [self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        // I edited this line so that the image view cannont move vertically
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y)];
        [gesture setTranslation:CGPointZero inView:[piece superview]];
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
        [self slideThenHide];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

//-------------end experiment---------




-(void)addBackButton{
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = backButton;
}
-(void)dismissSelf{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
