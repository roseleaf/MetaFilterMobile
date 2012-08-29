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
    self.rSSTable.delegate = self;
    self.rSSTable.dataSource = self;
    
}

- (void)viewDidUnload
{
    [self setRSSTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(void) rssFetcher {
    //use restkit to grab the rss feed
    RKClient *client = [RKClient clientWithBaseURLString:@"http://news.ycombinator.com/"];
//    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://news.ycombinator.com/"]];
//    xmlParser.delegate = self;
//    [xmlParser parse];
    
    client.requestQueue.requestTimeout = 10;
    client.cachePolicy = RKRequestCachePolicyNone;
    client.authenticationType = RKRequestAuthenticationTypeNone;
    
    [client get:@"rss" delegate:self];
    
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        id xmlParser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeXML];
        id parsedResponse = [xmlParser objectFromString:[response bodyAsString] error:nil];
        NSLog(@"%@", parsedResponse);
        NSDictionary* rss = parsedResponse;
        
        NSArray* rssChannelItemLevel = [[[rss valueForKey:@"rss"] valueForKey:@"channel"] valueForKey:@"item"];
        for (NSDictionary* itemDictionary in rssChannelItemLevel){
            RssItem* item = [RssItem new];
            item.title = [itemDictionary valueForKey:@"title"];
            item.link = [itemDictionary valueForKey:@"link"];
            [rssItemArray addObject:item];

        }
        [self.rSSTable reloadData];
    }
}



-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    RssItem* eachItem = [rssItemArray objectAtIndex:[indexPath row]];
    tableViewCell.textLabel.text = eachItem.title;

    return tableViewCell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [rssItemArray count];
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* rssItem = [rssItemArray objectAtIndex:[indexPath row]];
    NSString *tempURL = [rssItem valueForKey:@"link"];
    UINavigationController *nc = [UINavigationController new];
    PicturesViewController* pvc = [PicturesViewController new];
    pvc.rssItemLink = tempURL;
    
    NSLog(@"In List View DidSelect!!!!!!!");
    NSLog(@"%@", pvc.rssItemLink);

    [self presentModalViewController:pvc animated:YES];
}








- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
    if (request.method == RKRequestMethodGET) {
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
