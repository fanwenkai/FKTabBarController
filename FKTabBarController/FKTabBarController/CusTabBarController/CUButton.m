//
//  CUButton.m
//
//  Created by 你懂得的神 on 16/1/28.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CUButton.h"
#import "UIView+CUFrame.h"

#define kImageH 30
#define kImageW 30

@implementation CUButton


- (void)awakeFromNib
{
    [super awakeFromNib];
     [self setUp];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)init
{
    if (self == [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = self.width/2 - kImageW/2;
    self.imageView.y = 0;
    self.imageView.width = kImageW;
    self.imageView.height = kImageH;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
