//
//  NSString+Height.h
//  QuickAnimation
//
//  Created by Weilian on 07/12/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Height)


- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
