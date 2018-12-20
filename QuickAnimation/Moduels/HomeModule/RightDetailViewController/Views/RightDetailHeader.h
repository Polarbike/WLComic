//
//  RightDetailHeader.h
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailTittleButton;
@class ComicDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface RightDetailHeader : UIView

@property(nonatomic,strong) UILabel *name;//漫画名称

@property(nonatomic,strong) UILabel *author;//作者

@property(nonatomic,strong) UIImageView *imageView;//图片

//@property(nonatomic,strong) UILabel *typeTags;//用来展示漫画类型和标签
@property(nonatomic,strong) NSArray *tagArray;//漫画标签类型数组，遍历这个数组创建相应的label展示tag类型

@property(nonatomic,strong) UIImageView *backImageView;//背景图片用来模糊处理

@property(nonatomic,strong) DetailTittleButton *tittleButton;//标题按钮

@property(nonatomic,strong) ComicDetailModel *comicModel;//数据模型

- (void)setContentWithDictionary:(NSDictionary *)dic;

@property(nonatomic,strong) UIVisualEffectView *effectView;//模糊效果

@property(nonatomic,strong) UILabel *shortDescribe;

@end

NS_ASSUME_NONNULL_END
