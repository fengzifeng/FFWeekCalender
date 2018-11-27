//
//  FFWeekCalender.h
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/22.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFWeekCalender : UIView

@property (nonatomic,strong)NSDate *currentDate;
@property (nonatomic,strong)NSArray *chooseDates;//多选日期;

- (void)reloadCalender;
@end
