//
//  PicturesViewController.m
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "PicturesViewController.h"

@interface PicturesViewController ()

@end

@implementation PicturesViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.webView.delegate = self;
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString: self.rssItemLink]];
        NSLog(@"%@", self.rssItemLink);
        [self.webView loadRequest:requestObj];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    // Do any additional setup after loading the view from its nib.
    [self addBackButton];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString: self.rssItemLink]];
    NSLog(@"%@", self.rssItemLink);
    [self.webView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

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
