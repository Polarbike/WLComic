//
//  ScrollButton.h
//  QuickAnimation
//
//  Created by Weilian on 28/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonStopStatus) {
    
    stopLeftStatus,//确定背景图停下的状态，靠左边停下
    stopRightStatus,//确定背景图停下的状态，靠右边停下
};


NS_ASSUME_NONNULL_BEGIN

@protocol ScrollButtonClickDelegate <NSObject>

- (void)leftButtonClicked;
- (void)rightButtonClicked;

@end

@interface ScrollButton : UIView

@property(nonatomic,weak) id<ScrollButtonClickDelegate> delegate;

@property(nonatomic,strong) UIView *scroll_bg_view;//滑动的背景图
@property(nonatomic,strong) UIButton *leftButton;//左侧按钮
@property(nonatomic,strong) UIButton *rightButton;//右侧按钮

@property(nonatomic,assign) ButtonStopStatus stopStatus;//按钮停在下的状态


- (void)buttonScrollLeftToRight;
- (void)buttonScrollRightToLeft;

@end

NS_ASSUME_NONNULL_END
