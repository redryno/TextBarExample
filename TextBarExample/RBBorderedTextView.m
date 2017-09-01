//
//  RBBorderedTextView.m
//  TextBarExample
//
//  Created by Ryan Bigger on 9/29/16.
//  Copyright © 2017 Ryan Bigger. All rights reserved.
//

#import "RBBorderedTextView.h"

@implementation RBBorderedTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

@end
