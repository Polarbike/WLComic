//
//  CommentModel.h
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property(nonatomic,copy) NSString *nickname;//昵称
@property(nonatomic,copy) NSString *sex;//性别
@property(nonatomic,copy) NSString *content;//内容
@property(nonatomic,copy) NSString *content_filter;//过滤过的内容
@property(nonatomic,copy) NSString *face;//头像地址


@end

NS_ASSUME_NONNULL_END
