//
//  FFWeekCalenderModel.h
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/23.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFWeekCalenderModel : NSObject

@property (nonatomic, assign) BOOL isCurrentMonth;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isSelected;//是否是当前日期
@property (nonatomic, assign) BOOL isClick;//是否是点击的日期
@property (nonatomic, assign) BOOL isToday;//是否是今天
@property (nonatomic, assign) BOOL isChoose;//是否是选择的日期(同时选择多个日期的情况)

@end
