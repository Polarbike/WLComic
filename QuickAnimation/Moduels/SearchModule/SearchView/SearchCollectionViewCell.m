//
//  SearchCollectionViewCell.m
//  QuickAnimation
//
//  Created by Weilian on 21/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell


CGFloat itemHeight = 24.f;

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 12.f;
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = kRGB(251, 227, 76, 1);
        _backView.userInteractionEnabled = NO;
        [self addSubview:_backView];
        
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textColor = kRGB(40, 40, 40, 1);
        _itemLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_itemLabel];

}
    
    return self;
}

- (void)layoutSubviews {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).and.offset(2);
        make.left.mas_equalTo(self.mas_left).and.offset(2);
        make.right.mas_equalTo(self.mas_right).and.offset(-2);
        make.bottom.mas_equalTo(self.mas_bottom).and.offset(-2);
    }];
}



@end
