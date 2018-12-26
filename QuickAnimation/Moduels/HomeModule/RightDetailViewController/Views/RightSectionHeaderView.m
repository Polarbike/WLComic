//
//  RightSectionHeaderView.m
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RightSectionHeaderView.h"

@implementation RightSectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _cellIcon = [[UIImageView alloc] init];
        [self addSubview:_cellIcon];
        _cellTittle = [[UILabel alloc] init];
        _cellTittle.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _cellTittle.textColor = kRGB(40, 40, 40, 1);
        [self addSubview:_cellTittle];
        _moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreButton setTitle:@"更多" forState:(UIControlStateNormal)];
        _moreButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        [_moreButton setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
        [self addSubview:_moreButton];
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    CGFloat cell_height = self.frame.size.height;
    
    [self.cellIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo((cell_height-20)/2);
        make.left.mas_equalTo(self.mas_left).and.offset(12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [self.cellTittle mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo((cell_height-20)/2);
        make.left.mas_equalTo(self.cellIcon.mas_right).and.offset(8);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.mas_right).and.offset(-55);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo((cell_height-20)/2);
        make.right.mas_equalTo(self.mas_right).and.offset(-12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
