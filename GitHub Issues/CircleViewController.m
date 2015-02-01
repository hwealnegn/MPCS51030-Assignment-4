//
//  CircleViewController.m
//  GitHub Issues
//
//  Created by helenwang on 1/30/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)loadData {
    // GitHub API url
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=all";
    
    // Create NSUrlSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Create data download tasks
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                
                NSError *jsonError;
                self.issueData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&jsonError];
                // Log the data for debugging
                NSLog(@"DownloadedData:%@",self.issueData);
                
                // Use dispatch_async to update the table on the main thread
                // Remember that NSURLSession is downloading in the background
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.openTally = 0;
                    self.closedTally = 0;
                    
                    // Tally the number of open/closed issues
                    for (int i=0; i<[self.issueData count]; i++){
                        if ([[[self.issueData objectAtIndex:i] objectForKey:@"state"] isEqualToString:@"open"]){
                            self.openTally++;
                        }
                        if ([[[self.issueData objectAtIndex:i] objectForKey:@"state"] isEqualToString:@"closed"]){
                            self.closedTally++;
                        }
                    }
                    
                    // Update labels
                    self.openLabel.text = [NSString stringWithFormat:@"%ld Open Issues", self.openTally];
                    self.closedLabel.text = [NSString stringWithFormat:@"%ld Closed Issues", self.closedTally];
                });
            }] resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.issueData = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
