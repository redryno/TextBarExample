//
//  RBInputAccessoryObserverView.m
//  TextBarExample
//
//  Created by Ryan Bigger on 11/18/16.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import "RBInputAccessoryObserverView.h"

@implementation RBInputAccessoryObserverView

#pragma mark - Lifecycle

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:@"center"];
    }
    [newSuperview addObserver:self forKeyPath:@"center" options:0 context:nil];
    [super willMoveToSuperview:newSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.superview && [keyPath isEqualToString:@"center"]) {
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat offset = height - (self.superview.frame.origin.y + self.inputView.bounds.size.height);
        
        if (offset > 0 && self.inputView.bottomConstraint.constant > 0) {
            self.inputView.bottomConstraint.constant = MAX(0, offset);
            [self.inputView layoutIfNeeded];
        }
    }
}

@end
