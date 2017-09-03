//
//  RBInputAccessoryView.m
//  TextBarExample
//
//  Created by Ryan Bigger on 9/19/16.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import "RBInputAccessoryView.h"
#import "RBInputAccessoryObserverView.h"

@interface RBInputAccessoryView() <UITextViewDelegate>

@property (strong, nonatomic) NSLayoutConstraint *observerViewHeightConstraint;

@end

@implementation RBInputAccessoryView

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect frame = CGRectMake(0, 0, 320, 0);
    RBInputAccessoryObserverView *observerView = [[RBInputAccessoryObserverView alloc] initWithFrame:frame];
    observerView.backgroundColor = UIColor.clearColor;
    observerView.userInteractionEnabled = NO;
    observerView.writeTextView = self;
    self.observerView = observerView;
    self.textView.inputAccessoryView = observerView;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self observerViewHeight:self.bounds.size.height];
}

- (void)reset {
    self.textView.text = @"";
    self.textView.placeholderLabel.alpha = 1;
    self.button.enabled = NO;
}

#pragma mark - Private

- (NSLayoutConstraint *)observerViewHeightConstraint {
    if (_observerViewHeightConstraint) {
        return _observerViewHeightConstraint;
    }
    for (NSLayoutConstraint *constraint in [self.observerView constraints]) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            _observerViewHeightConstraint = constraint;
            break;
        }
    }
    return _observerViewHeightConstraint;
}

- (void)observerViewHeight:(CGFloat)height {
    self.observerViewHeightConstraint.constant = height;
    [self.observerView layoutIfNeeded];
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [self.textView resignFirstResponder];
    [self reset];
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(accessoryViewShouldBecomeActive)]) {
        return [self.delegate accessoryViewShouldBecomeActive];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.textView.placeholderLabel.alpha = (textView.text.length == 0) ? 1 : 0;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.textView.placeholderLabel.alpha = 0;
        self.button.enabled = YES;
    } else {
        self.textView.placeholderLabel.alpha = 1;
        self.button.enabled = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.textView.placeholderLabel.alpha = 1;
        self.button.enabled = NO;
    } else {
        self.textView.placeholderLabel.alpha = 0;
        self.button.enabled = YES;
    }
    [self observerViewHeight:0];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(accessoryViewDidEndEditing)]) {
        [self.delegate accessoryViewDidEndEditing];
    }
}

#pragma mark - Keyboard Handling

- (void)keyboardWillShow:(NSNotification *)aNotification inView:(UIView *)view {
    NSDictionary *info = aNotification.userInfo;
    CGFloat keyboardHeight = ((NSValue *)info[UIKeyboardFrameEndUserInfoKey]).CGRectValue.size.height;
    NSTimeInterval duration = ((NSNumber *)info[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    NSInteger curve = ((NSNumber *)info[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    
    if (self.bottomConstraint.constant == 0) {
        self.bottomConstraint.constant = keyboardHeight;
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:(curve << 16)
                         animations:^{
                             [view layoutIfNeeded];
                         } completion:nil];
    }
    
    [self observerViewHeight:self.bounds.size.height];
}

- (void)keyboardWillHide:(NSNotification *)aNotification inView:(UIView *)view {
    NSDictionary *userInfo = aNotification.userInfo;
    NSTimeInterval duration = ((NSNumber *)userInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    NSInteger curve = ((NSNumber *)userInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    
    if (self.bottomConstraint.constant != 0) {
        self.bottomConstraint.constant = 0;
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:(curve << 16)
                         animations:^{
                             [view layoutIfNeeded];
                         } completion:nil];
    }
    [self observerViewHeight:0];
}

@end
