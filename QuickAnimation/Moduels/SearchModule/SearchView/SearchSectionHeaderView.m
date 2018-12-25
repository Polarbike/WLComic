//
//  SearchSectionHeaderView.m
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "SearchSectionHeaderView.h"

@implementation SearchSectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _content = [[UILabel alloc] init];
        _content.textColor = kRGB(40, 40, 40, 1);
        _content.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        [self addSubview:_content];
        
        _headerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _headerButton.hidden = YES;
        [_headerButton setImage:[UIImage imageNamed:@"delete"] forState:(UIControlStateNormal)];
        [self addSubview:_headerButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    CGFloat height = self.frame.size.height;
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).offset(8);
        make.left.mas_equalTo(self.mas_left).offset(8);
        make.right.mas_equalTo(self.mas_right).and.offset(-padding.right);
        make.bottom.mas_equalTo(self.mas_bottom).and.offset(-8);
    }];
    [self.headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        CGFloat icon_top = (height - 16)/2;
        make.top.mas_offset(icon_top);
        make.right.mas_equalTo(self.mas_right).and.offset(-padding.right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
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
