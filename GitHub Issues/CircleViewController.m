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
                NSLog(@"HIIIDownloadedData:%@",self.issueData);
                
                // Use dispatch_async to update the table on the main thread
                // Remember that NSURLSession is downloading in the background
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.tableView reloadData];
                });
            }] resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.issueData = [[NSMutableArray alloc] init];
    [self loadData];
    //((CircleView *) self.view).openIssues = @"HELLO";
    // PARSE THROUGH WITH IF/ELSE FOR STATUSES (open/close)
    ((CircleView *) self.view).openIssues = [NSString stringWithFormat:@"Count: %lu",[self.issueData count]];
    NSLog(@"IS THIS WORKING??? %lu", [self.issueData count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
