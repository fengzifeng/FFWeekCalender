//
//  FFWeekCalender.m
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/22.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import "FFWeekCalender.h"
#import "UIView+Addition.h"
#import "FFWeekCalenderCell.h"
#import "FFWeekCalenderModel.h"
#import "FFWeekView.h"
#import "NSDate+Common.h"

#define PAGES_COUNT 3//滚动的页面数量

@interface FFWeekCalender ()<UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FFWeekView *weakView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic,assign) NSInteger currentMonthIndex;
@property (nonatomic,strong)NSDate *clickDate;//点击的日期

@end

@implementation FFWeekCalender

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

- (void)setupView
{
    [self getDateData];
    [self addSubview:self.collectionView];
    [self addSubview:self.titleButton];
    [self addSubview:self.weakView];
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

- (FFWeekView *)weakView
{
    if (!_weakView) {
        _weakView = [[FFWeekView alloc] initWithFrame:CGRectMake(0, self.titleButton.bottom, SCREENWIDTH, 30)];
    }
    return _weakView;
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.backgroundColor = [UIColor yellowColor];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _titleButton.frame = CGRectMake(20, 0, 200, 30);
        [_titleButton addTarget:self action:@selector(clickTitle) forControlEvents:UIControlEventTouchUpInside];
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _titleButton;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(self.frame.size.width/7, 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.weakView.bottom, SCREENWIDTH, 30) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[FFWeekCalenderCell class] forCellWithReuseIdentifier:NSStringFromClass([FFWeekCalenderCell class])];

        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar.timeZone = [NSTimeZone localTimeZone];
    }

    return _calendar;
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
}

- (void)setChooseDates:(NSArray *)chooseDates
{
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSDate *date in chooseDates) {
        [tempArray addObject:[date stringWithFormat:@"yyyMMdd"]];
    }
    self.chooseDates = [tempArray mutableCopy];
}

- (void)reloadCalender
{
    [self getDateData];
    //防止闪烁问题
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

- (void)clickTitle
{
    self.currentDate = [NSDate date];
    [self getDateData];
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

- (void)updateTitleView
{
    [self.titleButton setTitle:[NSString stringWithFormat:@"%@月",[NSString exchangeHanFromeint:self.currentMonthIndex]] forState:UIControlStateNormal];
}

- (void)getDateData
{
    self.currentDate = self.currentDate?:[NSDate date];
    [self.dataArray removeAllObjects];
    NSDate *currentDate = [self updateNewCurrentDate];
    self.currentDate = [currentDate beginningOfWeek];
    self.currentMonthIndex = [self.currentDate getMonth];
    [self updateTitleView];
    
    for(int i = 0; i < PAGES_COUNT; i++){
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.weekOfYear = i - PAGES_COUNT / 2;
        NSDate *beginDate = [self.calendar dateByAddingComponents:dayComponent toDate:[self.currentDate beginningOfWeek] options:0];
        NSArray *weekDateArray = [self createDaysOfWeek:beginDate];
        [self.dataArray addObject:weekDateArray];
    }
    
    [self.collectionView setContentOffset:CGPointMake(self.frame.size.width*round(PAGES_COUNT/2), 0)];
}

- (NSDate *)updateNewCurrentDate
{
    CGFloat tempPage = self.collectionView.contentOffset.x / self.width;
    int currentPage = roundf(tempPage);
    if (currentPage == round(PAGES_COUNT / 2)){
        return self.currentDate;
    }
    
    NSDateComponents *dayComponent = [NSDateComponents new];
    NSDate *currentDate;
    dayComponent.weekOfYear = currentPage - (PAGES_COUNT / 2);
    currentDate = [self.calendar dateByAddingComponents:dayComponent toDate:[self.currentDate beginningOfWeek] options:0];

    return currentDate;
}

- (NSArray *)createDaysOfWeek:(NSDate *)date
{
    NSMutableArray *arrary = [NSMutableArray new];
    
    for (NSInteger i=0; i<7; i++) {
        NSInteger monthIndex = [date getMonth];
        FFWeekCalenderModel *model = [[FFWeekCalenderModel alloc] init];
        model.isCurrentMonth = monthIndex == self.currentMonthIndex;
        model.date = date;
        if ([date isSameDayWithDate:self.currentDate]) {
            model.isSelected = YES;
        } else {
            model.isSelected = NO;
        }
        
        if ([date isToday]) {
            model.isToday = YES;
        } else {
            model.isToday = NO;
        }
        NSString *dateStr = [date stringWithFormat:@"yyyyMMdd"];
        if ([self.chooseDates containsObject:dateStr]) {
            model.isChoose = YES;
        } else {
            model.isChoose = NO;
        }
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 1;
        [arrary addObject:model];
        date = [self.calendar dateByAddingComponents:dayComponent toDate:date options:0];
    }
    return  arrary;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat tempPage = self.collectionView.contentOffset.x / self.width;
    
    int currentPage = roundf(tempPage);
    if (currentPage == round(PAGES_COUNT / 2))return;
    [self getDateData];
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FFWeekCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FFWeekCalenderCell class]) forIndexPath:indexPath];
    [cell setNeedsDisplay];
    [cell setNeedsDisplay];
    FFWeekCalenderModel *model = self.dataArray[indexPath.section][indexPath.row];
    if ([model.date isEqualToDate:self.clickDate]) {
        model.isClick = YES;
    } else {
        model.isClick = NO;
    }
    
    [cell updatecell:model];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return PAGES_COUNT;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FFWeekCalenderModel *model = self.dataArray[indexPath.section][indexPath.row];
    self.clickDate = model.date;
//    for (FFWeekCalenderCell *cell in [collectionView visibleCells]) {
//    }
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
    NSLog(@"点击%@",model.date);
}


@end
