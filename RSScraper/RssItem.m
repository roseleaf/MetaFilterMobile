//
//  RssItem.m
//  RSScraper
//
//  Created by Rose CW on 8/28/12.
//  Copyright (c) 2012 Rose and Ran. All rights reserved.
//

#import "RssItem.h"
#import "TFHpple.h"

@implementation RssItem

-(void)performBlockWithImages:(void (^) (UIImage*)) block{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^{
                       // if there isn't already an image:
                       //use NBProgressHUB to spin for a while when it is loading RSS
                       if (!self.image) {
                           // get the html document and images, use NSXMLParser and NSXMLDocument
                    
                           // do hpple parsing
                           self.image = [self hppleParse];//image returns from hpple
                           if (!self.image) {
                               self.image = [UIImage imageNamed:[NSString stringWithFormat:@"default.png"]];
                           }
                       }
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           
                           //update view: add images to table view
                           block(self.image);
                       });
                       
                   });
}

-(UIImage*) hppleParse {
    NSData  *data      = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.link]];
    TFHpple *doc       = [[TFHpple alloc] initWithHTMLData:data];
    //NSArray *elements  = [doc searchWithXPathQuery:@"//img[@src]"]; //grab first image
    NSArray *elements  = [doc searchWithXPathQuery:@"//link[@rel='icon']"]; //grab favicon

    if(![elements count]>=1){
         elements  = [doc searchWithXPathQuery:@"//link[@rel='shortcut icon']"]; //grab favicon
    }
    if([elements count]>=1){

        TFHppleElement *element = [elements objectAtIndex:0];
        //NSString *srcString = [element objectForKey:@"src"]; //grab image src
        NSString *srcString = [element objectForKey:@"href"]; //grab favicon src
        
        NSURL *url = [NSURL URLWithString:srcString];
        NSData *srcData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:srcData];
        
        NSLog(@"Element <src> parsed: %@",srcString);
        NSLog(@"%@", image);
        return image;
    }
    
    return nil;
}



@end
