//
//  ScrollButton.m
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#define kSCROLLButton_width self.frame.size.width
#define kSCROLLButton_height self.frame.size.height

#import "ScrollButton.h"

@interface ScrollButton ()


@property(nonatomic,strong) UIButton *selectButton;//标记已经选择的按钮，判断

@end

@implementation ScrollButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initSubviews];
        self.backgroundColor = kRGB(40, 40, 40, 1);
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.masksToBounds = YES;
        //初始停靠状态。靠右
        self.stopStatus = stopRightStatus;
    }
    return self;
}


- (void)initSubviews {
    
    _scroll_bg_view = [[UIView alloc] init];
    _scroll_bg_view.backgroundColor = kRGB(251, 227, 76, 1);
    [self addSubview:_scroll_bg_view];
    
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _leftButton.layer.cornerRadius = _leftButton.frame.size.height/2;
    [_leftButton setTitle:@"关注" forState:(UIControlStateNormal)];
    _leftButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    [_leftButton setTitleColor:kRGB(251, 227, 76, 1) forState:(UIControlStateNormal)];
    [self addSubview:_leftButton];
    _rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightButton setBackgroundColor:[UIColor clearColor]];
    [_rightButton setTitle:@"热门" forState:(UIControlStateNormal)];
    _rightButton.titleLabel.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    [_rightButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
    _rightButton.layer.cornerRadius = _rightButton.frame.size.height/2;
    [self addSubview:_rightButton];
    //给左侧按钮添加点击方法
    [_leftButton addTarget:self action:@selector(leftButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //给右侧按钮添加点击方法
    [_rightButton addTarget:self action:@selector(rightButtonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)layoutSubviews {
    
    CGFloat bg_width = self.frame.size.width;
    CGFloat bg_height = self.frame.size.height;
    self.scroll_bg_view.frame = CGRectMake(kSCROLLButton_width/2, 2, (kSCROLLButton_width-4)/2, kSCROLLButton_height-4);
    self.leftButton.frame = CGRectMake(0, 0, bg_width/2, bg_height);
    self.rightButton.frame = CGRectMake(bg_width/2, 0, bg_width/2, bg_height);
    //圆角
    _scroll_bg_view.layer.cornerRadius = _scroll_bg_view.frame.size.height/2;
    _scroll_bg_view.layer.masksToBounds = YES;
}

- (void)leftButtonClickAction:(UIButton *)button {
    
    if (self.stopStatus == stopRightStatus) {
        
        //设置颜色
        [button setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [self.rightButton setTitleColor:kRGB(251, 227, 76, 1) forState:(UIControlStateNormal)];
        //在这里完成动画后相应代理事件
        [UIView animateWithDuration:0.2 animations:^{
            //动画改变frame的数值。完成位移
            self.scroll_bg_view.frame = CGRectMake(2, 2, (kSCROLLButton_width-4)/2, kSCROLLButton_height-4);
            //相应代理方法
            if ([self->_delegate respondsToSelector:@selector(leftButtonClicked)]) {
                
                [self->_delegate leftButtonClicked];
            }
        } completion:^(BOOL finished) {
            //完成位移后进行的操作,预留空间
            self.stopStatus = stopLeftStatus;
        }];
    }
    
}

- (void)rightButtonClickAction:(UIButton *)button {
    
    if (self.stopStatus == stopLeftStatus) {
        
        //设置点击后button按钮的title字体颜色
        [button setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
        [self.leftButton setTitleColor:kRGB(251, 227, 76, 1) forState:(UIControlStateNormal)];
        //在这里完成动画后相应代理事件
        [UIView animateWithDuration:0.2 animations:^{
            
            self.scroll_bg_view.frame = CGRectMake(kSCROLLButton_width/2, 2, (kSCROLLButton_width-4)/2, kSCROLLButton_height-4);
            //响应代理方法
            if ([self->_delegate respondsToSelector:@selector(rightButtonClicked)]) {
                
                [self->_delegate rightButtonClicked];
            }
        } completion:^(BOOL finished) {
            //预留完成动画后要进行的操作
            self.stopStatus = stopRightStatus;
        }];
        
    }
    
}

- (void)buttonScrollLeftToRight {
    
    //设置点击后button按钮的title字体颜色
    [self.rightButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
    [self.leftButton setTitleColor:kRGB(251, 227, 76, 1) forState:(UIControlStateNormal)];
    //在这里完成动画后相应代理事件
    [UIView animateWithDuration:0.2 animations:^{
        
        self.scroll_bg_view.frame = CGRectMake(kSCROLLButton_width/2, 2, (kSCROLLButton_width-4)/2, kSCROLLButton_height-4);
//        //响应代理方法
//        if ([self->_delegate respondsToSelector:@selector(rightButtonClicked)]) {
//            
//            [self->_delegate rightButtonClicked];
//        }
    } completion:^(BOOL finished) {
        //预留完成动画后要进行的操作
        self.stopStatus = stopRightStatus;
    }];
    
}
//
- (void)buttonScrollRightToLeft {
    
    //设置点击后button按钮的title字体颜色 kRGB(251, 227, 76, 1)
    [self.rightButton setTitleColor:kRGB(251, 227, 76, 1) forState:(UIControlStateNormal)];
    [self.leftButton setTitleColor:kRGB(40, 40, 40, 1) forState:(UIControlStateNormal)];
    //在这里完成动画后相应代理事件
    [UIView animateWithDuration:0.2 animations:^{
        
        self.scroll_bg_view.frame = CGRectMake(2, 2, (kSCROLLButton_width-4)/2, kSCROLLButton_height-4);
    } completion:^(BOOL finished) {
        //预留完成动画后要进行的操作
        self.stopStatus = stopLeftStatus;
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
