//
//  PostViewController.m
//  RSScraper
//
//  Created by Rose CW on 9/9/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addBackButton];

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
