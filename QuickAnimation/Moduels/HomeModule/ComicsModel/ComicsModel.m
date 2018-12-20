//
//  ComicsModel.m
//  QuickAnimation
//
//  Created by Weilian on 05/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "ComicsModel.h"

@implementation ComicsModel

//- (void)setValue:(id)value forKey:(NSString *)key {
//    
//
//    
//    
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    if ([key isEqualToString:@"description"]) {
        
        _a_description = value;
    }
    
}



@end
