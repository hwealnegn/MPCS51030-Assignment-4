//
//  IssueDetailViewController.h
//  GitHub Issues
//
//  Created by helenwang on 1/30/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *currentIssue;

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *issueTitle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)openInSafari:(id)sender;

@end
