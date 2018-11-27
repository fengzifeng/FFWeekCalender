//
//  FFWeekCalenderCell.m
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/22.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import "FFWeekCalenderCell.h"
#import "FFWeekCalenderModel.h"
#import "NSDate+Common.h"
#import "UIView+Addition.h"

@interface FFWeekCalenderCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation FFWeekCalenderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
    }
    
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

- (void)updatecell:(id)data
{
    if (![data isKindOfClass:[FFWeekCalenderModel class]]) return;
    FFWeekCalenderModel *model = data;
    _label.text = [NSString stringWithFormat:@"%02ld",[model.date getDay]];
    _label.layer.cornerRadius = 0;
    _label.backgroundColor = [UIColor whiteColor];
    if (model.isToday) {
        _label.backgroundColor = [UIColor redColor];
        _label.layer.cornerRadius = _label.height/2.0;
        _label.layer.masksToBounds = YES;
    }
    if (model.isClick) {
        _label.backgroundColor = [UIColor blueColor];
        _label.layer.cornerRadius = _label.height/2.0;
        _label.layer.masksToBounds = YES;
    }
}

- (void)layoutSubviews
{
    _label.frame = CGRectMake((self.width - _label.width)/2.0, (self.height - _label.height)/2.0, _label.width, _label.height);
}
@end
