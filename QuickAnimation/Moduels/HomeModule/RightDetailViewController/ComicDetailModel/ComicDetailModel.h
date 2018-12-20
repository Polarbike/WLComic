//
//  ComicDetailModel.h
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicDetailModel : NSObject

@property(nonatomic,copy) NSString *all_description;
@property(nonatomic,copy) NSString *cate_id;//
@property(nonatomic,copy) NSString *last_update_week;//
@property(nonatomic,assign) long status;
@property(nonatomic,copy) NSString *ori;//原始图片
@property(nonatomic,copy) NSArray *classifyTags;//数组,所属类别数组
@property(nonatomic,copy) NSString *cover;//cover图片
@property(nonatomic,copy) NSString *name;//
@property(nonatomic,assign) long is_week;//
@property(nonatomic,copy) NSString *type;//类型
@property(nonatomic,copy) NSArray *theme_ids;//主题数组
@property(nonatomic,assign) long accredit;//信任
@property(nonatomic,copy) NSString *comic_id;//漫画ID
@property(nonatomic,copy) NSString *is_vip;//是否是VIP
@property(nonatomic,copy) NSString *thread_id;//thread_id
@property(nonatomic,copy) NSString *short_description;//短描述
@property(nonatomic,copy) NSString *level;
@property(nonatomic,assign) long is_dub;
@property(nonatomic,assign) long last_update_time;//
@property(nonatomic,copy) NSDictionary *author;//作者信息字典
@property(nonatomic,copy) NSString *series_status;//

@end

NS_ASSUME_NONNULL_END
