//
//  GalleryItemModel.m
//  QuickAnimation
//
//  Created by Weilian on 09/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "GalleryItemModel.h"

@implementation GalleryItemModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    if ([key isEqualToString:@"id"]) {
        
        _g_id = (long)value;
    }
    if ([key isEqualToString:kEXT]) {
        //
        NSArray *array = [NSArray arrayWithArray:(NSArray *)value];
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = array.firstObject;
        _comicId = dic[@"val"];
    }
    
    
}



@end
