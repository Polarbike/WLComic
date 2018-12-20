//
//  ClassModel.h
//  QuickAnimation
//
//  Created by Weilian on 10/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassModel : NSObject

@property(nonatomic,copy) NSString *cover;//图片
@property(nonatomic,assign) long sortId;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,assign) BOOL canEdit;
@property(nonatomic,assign) long argValue;//
@property(nonatomic,copy) NSString *argName;//
@property(nonatomic,copy) NSString *sortName;//排名名称

@end

NS_ASSUME_NONNULL_END
