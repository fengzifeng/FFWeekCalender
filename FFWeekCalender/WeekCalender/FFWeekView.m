//
//  FFWeekView.m
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/23.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import "FFWeekView.h"

@implementation FFWeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

- (NSMutableArray *)weekArray
{
    if (!_weekArray) {
        _weekArray = [NSMutableArray new];
    }
    return _weekArray;
}

- (void)setupView
{
    [self getWeekData];
    for(NSString *day in self.weekArray){
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = day;
        [self addSubview:label];
    }
}

- (void)getWeekData
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.weekArray = [[dateFormatter veryShortStandaloneWeekdaySymbols] mutableCopy];
}


- (void)layoutSubviews
{
    CGFloat x = 0;
    CGFloat width = self.frame.size.width/7;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
}



@end
