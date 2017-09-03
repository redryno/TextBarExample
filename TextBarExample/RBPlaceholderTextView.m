//
//  RBPlaceholderTextView.m
//  TextBarExample
//
//  Created by Ryan Bigger on 9/2/17.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import "RBPlaceholderTextView.h"

@interface RBPlaceholderTextView()

@property (nonatomic) IBInspectable BOOL removeInsets;
@property (strong, nonatomic) IBInspectable NSString *placeholder;

@property (strong, nonatomic) NSMutableDictionary<NSString *, NSLayoutConstraint *> *marginConstants;

@end

@implementation RBPlaceholderTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setRemoveInsets:(BOOL)removeInsets {
    _removeInsets = removeInsets;
    if (_removeInsets) {
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
        
        if (_marginConstants.count > 0) {
            for (NSString *key in _marginConstants) {
                NSLayoutConstraint *constraint = _marginConstants[key];
                constraint.constant = 0;
            }
        }
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = _placeholder;
}

- (void)setup {
    if (self.placeholderLabel != nil) {
        return;
    }
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.hidden = (self.text.length > 0);
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.textColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.84 alpha:1.0];
    self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.placeholderLabel];
    
    self.marginConstants = [[NSMutableDictionary alloc] init];
    
    CGFloat left = self.textContainerInset.left + self.textContainer.lineFragmentPadding;
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1
                                                                       constant:left];
    [self addConstraint:leftConstraint];
    self.marginConstants[@"left"] = leftConstraint;
    
    CGFloat right = self.textContainerInset.right + self.textContainer.lineFragmentPadding;
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1
                                                                        constant:right];
    [self addConstraint:rightConstraint];
    self.marginConstants[@"right"] = rightConstraint;
    
    CGFloat top = self.textContainerInset.top;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:top];
    [self addConstraint:topConstraint];
    self.marginConstants[@"top"] = topConstraint;
}

@end
