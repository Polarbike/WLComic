//
//  DetailTittleButton.h
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailTittleClickDelegate <NSObject>

- (void)clickedButton:(UIButton *)button index:(NSInteger)index;

@end

@interface DetailTittleButton : UIView



@property(nonatomic,strong) UIButton *oneButton;//第一个按钮

@property(nonatomic,strong) UIButton *twoButton;//第二个按钮

@property(nonatomic,strong) UIButton *threeButton;//第三个按钮

@property(nonatomic,strong) UIImageView *scrollBar;//按钮下滑动的bar

@property(nonatomic,weak) id<DetailTittleClickDelegate> buttonDelegate;//clickbutton按钮点击事件代理方法



#pragma mark -- 按钮bar移动动画
- (void)scrollBarScrollAnimation:(CGRect)frame;
//
- (void)oneButtonClickAction:(UIButton *)button;

- (void)quicklyScrollBarScrollAnimation:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
