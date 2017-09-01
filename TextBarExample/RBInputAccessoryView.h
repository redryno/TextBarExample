//
//  RBInputAccessoryView.h
//  TextBarExample
//
//  Created by Ryan Bigger on 9/19/16.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBBorderedTextView.h"

static const CGFloat RBInputAccessoryViewHeight = 44.0;

@interface RBInputAccessoryView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet RBBorderedTextView *textView;

@property (strong, nonatomic) UIView *observerView;
@property (strong, nonatomic) id userInfo;
@property (strong, nonatomic) id delegate;

- (void)keyboardWillShow:(NSNotification *)aNotification inView:(UIView *)view;
- (void)keyboardWillHide:(NSNotification *)aNotification inView:(UIView *)view;

@end

@protocol RBInputAccessoryViewDelegate <NSObject>

@optional
- (BOOL)accessoryViewShouldBecomeActive;
- (void)accessoryViewDidEndEditing;

@end
