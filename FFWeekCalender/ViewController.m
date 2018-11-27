//
//  ViewController.m
//  FFWeekCalender
//
//  Created by fengzifeng on 2018/11/22.
//  Copyright © 2018年 knowbox. All rights reserved.
//

#import "ViewController.h"
#import "FFWeekCalender.h"
#import "UIView+Addition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FFWeekCalender *weekCalender = [[FFWeekCalender alloc] initWithFrame:CGRectMake(0, 60, SCREENWIDTH, 100)];
    weekCalender.currentDate = [NSDate date];
    [weekCalender reloadCalender];
    [self.view addSubview:weekCalender];
}



@end
