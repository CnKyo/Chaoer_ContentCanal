//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCalendarItem.h"

@protocol FDCalendarDelegate;

@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;
@property (weak, nonatomic) id<FDCalendarDelegate> delegate;

@end
@protocol FDCalendarDelegate <NSObject>

- (void)calendar:(FDCalendarItem *)item didSelectedDate:(NSDate *)date;

@end