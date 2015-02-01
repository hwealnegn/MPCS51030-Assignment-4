//
//  CircleView.m
//  GitHub Issues
//
//  Created by helenwang on 1/31/15.
//  Copyright (c) 2015 helenwang. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Reference to draw circle: http://www.ioscreator.com/tutorials/drawing-shapes-with-core-graphics
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
    // Reference to set color: https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CGContext/index.html#//apple_ref/doc/c_ref/CGContextSetRGBStrokeColor
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(ctx, 5);
    CGContextAddArc(ctx, center.x, center.y, 100.0, 0, 2*3.14159265, 0);
    CGContextStrokePath(ctx);
    
    // Add label at center of circle
    CGFloat labelWidth = 150;
    CGFloat labelHeight = 150;
    UILabel *issues = [[UILabel alloc] initWithFrame:CGRectMake(center.x-(labelWidth/2), center.y-(labelHeight/2), labelWidth, labelHeight)];
    issues.textAlignment = NSTextAlignmentCenter;
    issues.textColor = [UIColor blackColor];
    issues.text = self.openIssues;
    [self addSubview:issues];
}


@end
