# FFWeekCalender
自定义周日历(WeekCalender),左右滑动,可扩展性高,使用简单,会一直优化,扩展
![演示图](https://github.com/fengzifeng/FFWeekCalender/blob/master/FFWeekCalender/weekCalender.gif)

用法:
1.初始化FFWeekCalender.
    FFWeekCalender *weekCalender = [[FFWeekCalender alloc] initWithFrame:frame];
2.设置currentDate属性,初始化日历显示的当前日期,不选默认是当天.
    weekCalender.currentDate = [NSDate date];
3.更新日历
- (void)reloadCalender;
4.weekCalender.chooseDates选择多个日期标记.它是个数组,元素是NSDate
