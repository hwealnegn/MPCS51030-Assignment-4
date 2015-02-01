//
//  CircleView.h
//  GitHub Issues
//
//  Created by helenwang on 1/31/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property NSInteger openIssues;
@property NSInteger closedIssues;

- (void) retrieveData:(float)x :(float)y;

@end