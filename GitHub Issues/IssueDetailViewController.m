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
    self.status.text = [self.currentIssue objectForKey:@"state"];
    
    // References to display user avatar:
    // http://stackoverflow.com/questions/16481166/xcode-string-url-to-image
    // http://stackoverflow.com/questions/6456605/nsstring-to-nsurl
    NSURL *url = [NSURL URLWithString:[self.currentIssue valueForKeyPath:@"user.avatar_url"]];
    NSData *data = [NSData dataWithContentsOfURL: url];
    self.authorImage.image = [UIImage imageWithData: data];
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

- (IBAction)openInSafari:(id)sender {
    // Reference: http://stackoverflow.com/questions/11524805/how-to-open-the-url-in-safari-not-in-webview
    NSURL *issueURL = [NSURL URLWithString:[self.currentIssue objectForKey:@"html_url"]];
    [[UIApplication sharedApplication] openURL:issueURL];
}
@end
