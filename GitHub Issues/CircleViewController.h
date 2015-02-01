//
//  CircleViewController.h
//  GitHub Issues
//
//  Created by helenwang on 1/30/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *issueData;
@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *closedLabel;
@property NSInteger openTally;
@property NSInteger closedTally;

@end
