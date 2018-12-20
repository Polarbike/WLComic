//
//  HomeModel.m
//  QuickAnimation
//
//  Created by Weilian on 12/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "HomeModel.h"
#import "ComicsModel.h"

@implementation HomeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"description"]) {
        
        _a_description = value;
    }
    if ([key isEqualToString:@"comics"]) {
        
//        _comicsData = value;
        _comicsData = [[NSMutableArray alloc] init];
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //
            
            NSDictionary *dic = (NSDictionary *)obj;
            ComicsModel *comicModel = [[ComicsModel alloc] init];
            [comicModel setValuesForKeysWithDictionary:dic];
            [self.comicsData addObject:comicModel];
        }];
        
    }
    
}




@end
