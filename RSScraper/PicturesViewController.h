//
//  PicturesViewController.h
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssItem.h"

@interface PicturesViewController : UIViewController <UIWebViewDelegate, NSURLConnectionDelegate>
@property RssItem* rssItem;
@property NSString* rssItemLink;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
