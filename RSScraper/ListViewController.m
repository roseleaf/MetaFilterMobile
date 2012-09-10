//
//  ListViewController.m
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "ListViewController.h"
#import <RestKit/RestKit.h>
#import "RssItem.h"
#import "PicturesViewController.h"
#import "PostTableViewCell.h"
#import "PostViewController.h"
#import "AppDelegate.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, RKRequestDelegate, NSXMLParserDelegate>{
    NSMutableArray* rssItemArray;
}

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        rssItemArray = [NSMutableArray new];
        [self rssFetcher];
    }

    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 146;
    
}


//Set up TableView Header:
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    self.header = [UIImageView new];
    self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar.png"]];
    self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    [self.view addSubview:self.header];
    UILabel *headerLabel =
    [[UILabel alloc]
     initWithFrame:CGRectMake(120, 15, 300, 29)];
    headerLabel.text = NSLocalizedString(@"Recent", @"");
    headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    headerLabel.shadowColor = [UIColor blackColor];
    headerLabel.shadowOffset = CGSizeMake(0, -1);
    headerLabel.font = [UIFont boldSystemFontOfSize:20];
    headerLabel.backgroundColor = [UIColor clearColor];
    
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    [view addSubview:self.header];
    [view addSubview:headerLabel];
    
    return view;
}


//TableView Delegate Methods:
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RssItem* eachItem = [rssItemArray objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"Cell";
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PostTableViewCell alloc]init];
    }
    
    //    [eachItem performBlockWithImages:^(UIImage* img){
    //        eachItem.image = img;
    //        tableViewCell.imageView.image = img;
    //        [tableViewCell setNeedsLayout];
    //    }];
    
    
    NSString *string = eachItem.linkDescription;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<.*?>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@" "];
        
    eachItem.textOnlyDesc = modifiedString;
    cell.primaryLabel.text = modifiedString;

    cell.primaryLabel.font = [UIFont fontWithName:@"helvetica" size:13];
    cell.postedByLabel.text = [NSString stringWithFormat:@"Posted by: %@", eachItem.creator];
    cell.postedByLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [rssItemArray count];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* rssItem = [rssItemArray objectAtIndex:[indexPath row]];
    //NSString *tempURL = [rssItem valueForKey:@"link"];
    //PicturesViewController* pvc = [PicturesViewController new];
    //    pvc.rssItemLink = tempURL;
    PostViewController* pvc = [PostViewController new];
    pvc.rssItem = rssItem;
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:pvc];
    [self presentModalViewController:navController animated:YES];
    [pvc slideThenHide];
    //[app_delegate showSideMenuWithView:pvc];

}





//use restkit to grab the rss feed
-(void) rssFetcher {
    RKClient *client = [RKClient clientWithBaseURLString:@"http://feeds.feedburner.com/"];
    
    client.requestQueue.requestTimeout = 10;
    client.cachePolicy = RKRequestCachePolicyNone;
    client.authenticationType = RKRequestAuthenticationTypeNone;
    
    [client get:@"Metafilter" delegate:self];
    
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        id xmlParser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeXML];
        id parsedResponse = [xmlParser objectFromString:[response bodyAsString] error:nil];
        NSDictionary* rss = parsedResponse;
        
        NSArray* rssChannelItemLevel = [[[rss valueForKey:@"rss"] valueForKey:@"channel"] valueForKey:@"item"];
        for (NSDictionary* itemDictionary in rssChannelItemLevel){
            RssItem* item = [RssItem new];
            item.linkDescription = [itemDictionary valueForKey:@"description"];
            item.title = [itemDictionary valueForKey:@"title"];
            item.link = [itemDictionary valueForKey:@"link"];
            [rssItemArray addObject:item];
            item.creator = [itemDictionary valueForKey:@"dc:creator"];

        }

        [self.tableView reloadData];
    }
}






- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
    if (request.method == RKRequestMethodGET) {
    }
}

-(void)refresh{
    [self rssFetcher];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];

}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
