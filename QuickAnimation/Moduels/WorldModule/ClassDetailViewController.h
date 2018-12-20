//
//  ClassDetailViewController.h
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassDetailViewController : BaseViewController
//设置动画名称，及分类号，传递过来进行网络请求
@property(nonatomic,copy) NSString *argName;
@property(nonatomic,strong) NSNumber *argValue;

@end

NS_ASSUME_NONNULL_END
