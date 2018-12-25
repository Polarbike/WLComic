//
//  SearchBar.m
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.placeholder = @"请输入漫画名称或作者";
        _searchTextField.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _searchTextField.textColor = kRGB(40, 40, 40, 1);
        _searchTextField.keyboardType = UIKeyboardTypeWebSearch;
        [self addSubview:_searchTextField];
        
        _sureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sureButton setTitle:@"搜索" forState:(UIControlStateNormal)];
        _sureButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _sureButton.titleLabel.textColor = kRGB(40, 40, 40, 1);
        [self addSubview:_sureButton];
    }
    self.backgroundColor = [UIColor redColor];
    return self;
}

- (void)layoutSubviews {
    
//  CGFloat height = self.frame.size.height;
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(padding.top);
        make.left.mas_equalTo(self.mas_left).and.offset(padding.left);
        make.right.mas_equalTo(self.mas_right).and.offset(56);
        make.bottom.mas_equalTo(-padding.bottom);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.searchTextField.mas_top);
        make.right.mas_equalTo(self.mas_right).and.offset(-8);
        make.width.mas_equalTo(40);
        make.bottom.mas_equalTo(-padding.bottom);
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
