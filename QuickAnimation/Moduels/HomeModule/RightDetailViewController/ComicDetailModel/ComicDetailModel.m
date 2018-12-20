//
//  ComicDetailModel.m
//  QuickAnimation
//
//  Created by Weilian on 06/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ComicDetailModel.h"

@implementation ComicDetailModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    if ([key isEqualToString:@"description"]) {
        
        _all_description = value;
    }
    
}

@end
