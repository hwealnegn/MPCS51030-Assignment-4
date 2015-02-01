//
//  IssueTableViewController.m
//  GitHub Issues
//
//  Created by helenwang on 1/30/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import "IssueTableViewController.h"
#import "IssueTableViewCell.h"
#import "IssueDetailViewController.h"

@interface IssueTableViewController ()

- (void)refreshTable;

@end

@implementation IssueTableViewController

- (void)refreshTable {
    NSLog(@"Refreshing");
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)loadData {
    // GitHub API url
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=open";
    
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
                    [self.tableView reloadData];
                });
            }] resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.issueData = [[NSMutableArray alloc] init];
    
    // Add UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.issueData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSLog(@"Working on cell:%ld", (long)indexPath.row);
    cell.title.text = [[self.issueData objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.author.text = [[self.issueData objectAtIndex:indexPath.row] valueForKeyPath:@"user.login"];
    cell.date.text = [[self.issueData objectAtIndex:indexPath.row] objectForKey:@"created_at"];
    
    NSString *status = [[self.issueData objectAtIndex:indexPath.row] objectForKey:@"state"];
    if ([status isEqualToString:@"open"]) {
        cell.statusImage.image = [UIImage imageNamed:@"question-100.png"];
    }
    else if ([status isEqualToString:@"closed"]) {
        cell.statusImage.image = [UIImage imageNamed:@"cool-100.png"];
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"segueIssueDetails"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *issue = [self.issueData objectAtIndex:indexPath.row];
        IssueDetailViewController *issueDetails = [segue destinationViewController];
        [issueDetails setCurrentIssue:issue];
    }
}

- (IBAction)test:(id)sender {
}
@end
