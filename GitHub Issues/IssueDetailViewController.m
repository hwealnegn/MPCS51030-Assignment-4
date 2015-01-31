//
//  IssueDetailViewController.m
//  GitHub Issues
//
//  Created by helenwang on 1/30/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import "IssueDetailViewController.h"

@interface IssueDetailViewController ()

@end

@implementation IssueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.issueTitle.text = [self.currentIssue objectForKey:@"title"];
    self.author.text = [self.currentIssue valueForKeyPath:@"user.login"];
    self.date.text = [self.currentIssue objectForKey:@"created_at"];
    
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

/*- (IBAction)moreDetails:(id)sender {
}*/

@end
