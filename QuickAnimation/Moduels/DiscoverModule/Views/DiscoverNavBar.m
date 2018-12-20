//
//  DiscoverNavBar.m
//  QuickAnimation
//
//  Created by Weilian on 29/11/18.
//  Copyright © 2018年 Weilian. All rights reserved.
//

#import "DiscoverNavBar.h"

@implementation DiscoverNavBar


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _searchButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_searchButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [self addSubview:_searchButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    self.searchButton.frame = CGRectMake(0, 0, kSCREEN_Width, 20);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
