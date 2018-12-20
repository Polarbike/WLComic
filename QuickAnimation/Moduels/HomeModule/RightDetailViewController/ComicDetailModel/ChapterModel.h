//
//  ChapterModel.h
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChapterModel : NSObject

@property(nonatomic,copy) NSString *image_total;//总图片的个数
@property(nonatomic,copy) NSArray *imaHightArr;//高度的数组
@property(nonatomic,copy) NSString *pass_time;//
@property(nonatomic,copy) NSString *release_time;//
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *size;//
@property(nonatomic,copy) NSString *chapter_id;//449371
@property(nonatomic,copy) NSString *price;//
@property(nonatomic,copy) NSString *zip_high_webp;//
@property(nonatomic,assign) BOOL has_locked_image;//
@property(nonatomic,assign) long is_new;
@property(nonatomic,assign) long countImHightArr;
@property(nonatomic,copy) NSString *name;//名字
@property(nonatomic,copy) NSString *crop_zip_size;//压缩大小


@end

NS_ASSUME_NONNULL_END
