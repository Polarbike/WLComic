//
//  DetailTittleButton.m
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "DetailTittleButton.h"

@interface DetailTittleButton ()

@property(nonatomic,strong) UIButton *selectedButton;//用来标记被选择的按钮

@end

@implementation DetailTittleButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _oneButton = [self getSameSetButton];
        [_oneButton addTarget:self action:@selector(oneButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_oneButton setTitle:@"详情" forState:(UIControlStateNormal)];
        //默认第一个按钮被选择，字体颜色改变
        [_oneButton setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
        [self addSubview:_oneButton];
        _twoButton = [self getSameSetButton];
        [_twoButton setTitle:@"目录" forState:(UIControlStateNormal)];
        [_twoButton addTarget:self action:@selector(twoButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_twoButton];
        _threeButton = [self getSameSetButton];
        [_threeButton addTarget:self action:@selector(threeButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_threeButton setTitle:@"评论" forState:(UIControlStateNormal)];
        [self addSubview:_threeButton];
        
        _scrollBar = [[UIImageView alloc] init];
        //设置拉伸图片
        UIImage *image = [UIImage imageNamed:@"bg_button_login_longest_10x10_"];
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        // 设置端盖的值
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 设置拉伸的模式
        UIImageResizingMode mode = UIImageResizingModeStretch;
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
        _scrollBar.image = newImage;
        [self addSubview:_scrollBar];
        //设置默认第一个按钮被选中
        _selectedButton = _oneButton;
        //设置背景色
        self.backgroundColor = kRGB(240, 240, 240, 0.5);
    }
    return self;
}



- (void)layoutSubviews {
    
    CGFloat total_height = self.frame.size.height;
    CGFloat button_width = kSCREEN_Width/3;
    
    self.oneButton.frame = CGRectMake(0, 0, button_width, total_height-2);
    self.twoButton.frame = CGRectMake(button_width, 0, button_width, total_height-2);
    self.threeButton.frame = CGRectMake(button_width*2, 0, button_width, total_height-2);
    
    self.scrollBar.frame = CGRectMake(0, total_height-2, button_width, 1.5);
}

#pragma mark -- 返回相同规格的按钮
- (UIButton *)getSameSetButton {
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:15];
    
    return button;
}
#pragma mark -- 按钮点击方法,在三个按钮点击方法中判断，改变scrollbar的frame,并传递给代理

- (void)oneButtonClickAction:(UIButton *)button {
    
    if (![button isEqual:_selectedButton]) {
        
        [button setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
        [self scrollBarScrollAnimation:button.frame];
        [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        self.selectedButton = button;
    }
    //第一个按钮点击方法
    if ([_buttonDelegate respondsToSelector:@selector(clickedButton:index:)]) {
        
        [_buttonDelegate clickedButton:button index:0];
    }
}

- (void)twoButtonClickAction:(UIButton *)button {
    
    if (![button isEqual:_selectedButton]) {
        
        [button setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
        [self scrollBarScrollAnimation:button.frame];
        [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        self.selectedButton = button;
    }
    //第二个按钮点击方法
    if ([_buttonDelegate respondsToSelector:@selector(clickedButton:index:)]) {
        
        [_buttonDelegate clickedButton:button index:1];
    }
    
}

- (void)threeButtonClickAction:(UIButton *)button {
    
    if (![button isEqual:_selectedButton]) {
        
        [button setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
        [self scrollBarScrollAnimation:button.frame];
        [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];

        self.selectedButton = button;
    }
    //第三个按钮点击方法
    if ([_buttonDelegate respondsToSelector:@selector(clickedButton:index:)]) {
        
        [_buttonDelegate clickedButton:button index:2];
    }
    
}
#pragma mark -- 按钮bar移动动画
- (void)scrollBarScrollAnimation:(CGRect)frame {
    
    [UIView animateWithDuration:0.25 animations:^{
        //根据offset偏移量多少进行动画
        self.scrollBar.frame = CGRectMake(frame.origin.x, self.frame.size.height-2, kSCREEN_Width/3, 1.5);
        
    }];
//    if (frame.origin.x == 0) {
//        self.selectedButton = self.oneButton;
//    }else if(frame.origin.x == kSCREEN_Width){
//        self.selectedButton = self.twoButton;
//    }else if(frame.origin.x == kSCREEN_Width*2){
//        self.selectedButton = self.threeButton;
//    }//selectedBu
}

- (void)quicklyScrollBarScrollAnimation:(CGRect)frame {
    
    [UIView animateWithDuration:0.15 animations:^{
        //根据offset偏移量多少进行动画
        self.scrollBar.frame = CGRectMake(frame.origin.x, self.frame.size.height-2, kSCREEN_Width/3, 1.5);
        
    }];
        if (frame.origin.x == self.oneButton.frame.origin.x) {
            
            [self.oneButton setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
            //防止滑动到最左边后仍向左划会改变selectedbutton按钮颜色，下边第三个按钮同理
            if (![self.selectedButton isEqual:self.oneButton]) {
                
                [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
            }
            self.selectedButton = self.oneButton;
        }else if(frame.origin.x == self.twoButton.frame.origin.x){
            
            [self.twoButton setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
            [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
            self.selectedButton = self.twoButton;
        }else if(frame.origin.x == self.threeButton.frame.origin.x){
            
            [self.threeButton setTitleColor:kRGB(245, 188, 69, 1) forState:(UIControlStateNormal)];
            if (![self.selectedButton isEqual:self.threeButton]) {
                
                [self.selectedButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
            }
            self.selectedButton = self.threeButton;
        }//selectedBu
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
