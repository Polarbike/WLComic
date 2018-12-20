//
//  RightDetailHeader.m
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "RightDetailHeader.h"
#import "DetailTittleButton.h"
#import "ComicDetailModel.h"//动漫详情

@interface RightDetailHeader ()

@property(nonatomic,strong) NSMutableArray *labelArray;//存储label数组

@end

@implementation RightDetailHeader


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _backImageView = [[UIImageView alloc] init];
//        [self addSubview:_backImageView];
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:_effectView];
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        //为背景图片添加高斯模糊状态
        
        _name = [[UILabel alloc] init];
        _name.font = [UIFont fontWithName:Font_Name_PFSC size:16];
        _name.textColor = kRGB(40, 40, 40, 1);
//        _name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_name];
        
        _author = [[UILabel alloc] init];
        _author.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
//        _author.textAlignment = NSTextAlignmentCenter;
        _author.textColor = kRGB(50, 50, 50, 1);
        [self addSubview:_author];
        
        _shortDescribe = [[UILabel alloc] init];
        _shortDescribe.font = [UIFont fontWithName:Font_Name_PFSCRe size:13];
        _shortDescribe.textColor = kRGB(50, 50, 50, 1);
        [self addSubview:_shortDescribe];
        
        _tittleButton = [[DetailTittleButton alloc] init];
        [self addSubview:_tittleButton];
        
        self.backgroundColor =  [UIColor whiteColor];
    }
    
    return self;
}

/**
 初始化完成后的布局方法
 */
- (void)layoutSubviews {
    
//    CGFloat frame_height = self.frame.size.height;
////    CGFloat frame_width = self.frame.size.width;
//    CGFloat spaceHeight = 18;
//    CGFloat name_height = 26;
//    CGFloat author_height = 18;
//    CGFloat name_y = (frame_height-name_height-spaceHeight-author_height)/2;
//
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //imageView布局
//
//    }];
//    self.name.frame = CGRectMake(0, name_y, kSCREEN_Width, name_height);
//    self.author.frame = CGRectMake(0, name_y+name_height+spaceHeight, kSCREEN_Width, author_height);
//
//    self.tittleButton.frame = CGRectMake(0, name_y+name_height+spaceHeight+author_height, kSCREEN_Width, 40);
    //使用masonry布局
    UIEdgeInsets padding = UIEdgeInsetsMake(12, 12, 12, 12);
    //布局完其他的控件，遍历label数组
//    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //
//        make.top.mas_equalTo(self.mas_top);
//        make.left.mas_equalTo(self.mas_left);
//        make.right.mas_equalTo(self.mas_right);
//        make.bottom.mas_equalTo(self.mas_bottom);
//    }];
//    self.effectView.frame = self.backImageView.bounds;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.mas_top).and.offset(padding.top);
        make.left.mas_equalTo(self.mas_left).and.offset(padding.left);
        make.width.mas_equalTo(kSCREEN_Width/2);
        make.height.mas_equalTo(self.frame.size.height-64);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.mas_equalTo(self.imageView.mas_right).and.offset(padding.right);
        make.top.mas_equalTo(self.imageView.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(22);
    }];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.name.mas_bottom).offset(padding.bottom);
        make.left.mas_equalTo(self.name.mas_left);
        make.right.mas_equalTo(self.name.mas_right);
        make.height.mas_equalTo(20);
    }];
    [self.shortDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.mas_equalTo(self.author.mas_bottom).offset(padding.bottom);
        make.left.mas_equalTo(self.name.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    [self.labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        UILabel *label = (UILabel *)obj;
        CGFloat label_x = self.name.frame.origin.x;
        CGFloat cutting = 10;//间隔距离
        CGFloat width = 40;
        CGFloat label_y = self.shortDescribe.frame.origin.y+self.shortDescribe.frame.size.height+padding.bottom+20;
        label.frame = CGRectMake(label_x+idx*width+idx*cutting, label_y, width, 22);
    }];
    [self.tittleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)setContentWithDictionary:(NSDictionary *)dic {
    
    if (dic) {
        
        self.name.text = dic[@"name"];
        self.author.text = [NSString stringWithFormat:@"作者：%@",dic[@"author"]];
    }
}
#pragma mark -- 重写model的set方法为控件赋值
- (void)setComicModel:(ComicDetailModel *)comicModel {
    
    _comicModel = comicModel;
//    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:comicModel.ori]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:comicModel.cover]];
    self.name.text = comicModel.name;
    self.author.text = [NSString stringWithFormat:@"作者：%@",comicModel.author[@"name"]];
    self.shortDescribe.text = comicModel.short_description;
    self.tagArray = comicModel.classifyTags;
    
}
#pragma mark -- 重写array的set方法
- (void)setTagArray:(NSArray *)tagArray {
   
    _tagArray = tagArray;
    for (NSDictionary *dic in tagArray) {
        //取出字典中名字
        NSString *name = dic[@"name"];
        //遍历stag数组
        UILabel *label = [self getTagLabelWithTittle:name];
        [self addSubview:label];
        [self.labelArray addObject:label];
        //用数组存储label 再在layout方法里，布局，创建头部视图
    }
    
}
//封装创建标签label的方法
- (UILabel *)getTagLabelWithTittle:(NSString *)tittle {
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = tittle;
    label.textColor = kRGB(40, 40, 40, 1);
    label.font = [UIFont fontWithName:Font_Name_PFSCRe size:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 11.f;
//    // 加载拉伸的图片
//    UIImage *image = [UIImage imageNamed:@"bg_button_login_longest_10x10_"];
//    // 设置端盖的值
//    CGFloat top = image.size.height * 0.5;
//    CGFloat left = image.size.width * 0.5;
//    CGFloat bottom = image.size.height * 0.5;
//    CGFloat right = image.size.width * 0.5;
//    // 设置端盖的值
//    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 设置拉伸的模式
//    UIImageResizingMode mode = UIImageResizingModeStretch;
//    // 拉伸图片
//    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    UIColor *color = kRGB(251, 227, 76, 1);
    label.backgroundColor = color;
    return label;
}

#pragma mark -- 懒加载label数组
- (NSMutableArray *)labelArray {
    
    if (!_labelArray) {
        
        
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
