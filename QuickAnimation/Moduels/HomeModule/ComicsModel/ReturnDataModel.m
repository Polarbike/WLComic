//
//  ReturnDataModel.m
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ReturnDataModel.h"
#import "ComicsModel.h"

@implementation ReturnDataModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"spinnerList"]) {
        
        _spinnerList = value;
    }
    if ([key isEqualToString:@"page"]) {
        
        _page = (long)value;
    }
    if ([key isEqualToString:@"defaultParameters"]) {
        
        _defaultParameters = value;
    }
    if ([key isEqualToString:@"hasMore"]) {
        
        _hasMore = value;
    }
    if ([key isEqualToString:@"comics"]) {
        
        _comics = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)value;
        for (NSDictionary *dic in array) {
            
            ComicsModel *model = [[ComicsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_comics addObject:model];
        }
    }
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    

    
}

@end
