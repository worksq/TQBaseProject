//
//  UIView+Extension.m

//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setPixelFrame:(CGRect)pixelFrame{
    CGFloat rate = 0.4266;
    self.frame = CGRectMake(pixelFrame.origin.x * rate, pixelFrame.origin.y * rate, pixelFrame.size.width * rate, pixelFrame.size.height *rate);
}

- (CGRect)pixelFrame{
    CGFloat rate = 0.4266;
    return CGRectMake(self.frame.origin.x / rate, self.frame.origin.y / rate, self.frame.size.width / rate, self.frame.size.height / rate);
}


- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)bottom{
    return  self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right{
    return self.frame.origin.x +self.frame.size.width;
}

- (UIViewController *)viewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                         class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setViewController:(UIViewController *)viewController{}


// Recursively travel down the view tree, increasing the indentation level for children
+ (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableString *)outstring
{
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    aView.backgroundColor = [UIColor clearColor];
    [outstring appendFormat:@"[%2d] %@==%ld\n", indent, [[aView class] description],(long)aView.tag];
    
    for (UIView *view in [aView subviews])
        [self dumpView:view atIndent:indent + 1 into:outstring];
}

+ (void)dumpView:(UIView *)aView atIndent:(int)indent block:(next_view_block)nextView{
    NSMutableString *outstring = [[NSMutableString alloc] init];
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    aView.backgroundColor = [UIColor clearColor];
    [outstring appendFormat:@"[%2ld] %@==%ld\n", (long)indent, [[aView class] description],(long)aView.tag];
    
    for (UIView *view in [aView subviews]){
        if (nextView) {
            nextView(indent,view);
        }
        [UIView dumpView:view atIndent:indent + 1 block:nextView];
    }
}

// Start the tree recursion at level 0 with the root view
+ (NSString *) displayViews: (UIView *) aView
{
    NSMutableString *outstring = [[NSMutableString alloc] init];
    [UIView dumpView: aView atIndent:0 into:outstring];
    return outstring;
}



// Show the tree
+ (void)logViewTreeForMainWindow: (UIView *) aView
{
    //  CFShow([self displayViews: self.window]);
    NSLog(@"The view tree:\n%@", [self displayViews:aView]);
}

@end
