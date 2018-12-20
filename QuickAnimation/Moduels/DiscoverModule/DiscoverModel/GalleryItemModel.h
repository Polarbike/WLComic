//
//  GalleryItemModel.h
//  QuickAnimation
//
//  Created by Weilian on 09/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kEXT @"ext"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryItemModel : NSObject

@property(nonatomic,assign) long g_id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *comicId;
@property(nonatomic,copy) NSString *cover;//
@property(nonatomic,assign) long linkType;//链接类型


@end

NS_ASSUME_NONNULL_END
