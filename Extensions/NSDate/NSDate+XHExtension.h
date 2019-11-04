//
//  NSDate+XHExtension.h
//  日历选择器
//
//  Created by 向洪 on 16/6/30.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NSDateStringFormatCNValue1Style,
    NSDateStringFormatCNValue2Style,
} NSDateStringFormatCNStyle;

/**
 
 时间处理扩展，
 节假日未实现
 
 */
@interface NSDate (XHExtension)

#pragma mark - 初始化

+ (instancetype)xh_dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)xh_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (instancetype)xh_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

#pragma mark - 按格式转字符串
- (NSString *)xh_stringWithformat:(NSString *)format;

#pragma mark - 日期属性
@property (nonatomic, readonly) NSInteger xh_year;
@property (nonatomic, readonly) NSInteger xh_month;
@property (nonatomic, readonly) NSInteger xh_day;
@property (nonatomic, readonly) NSInteger xh_hour;
@property (nonatomic, readonly) NSInteger xh_minute;
@property (nonatomic, readonly) NSInteger xh_second;

#pragma mark - day相关
// 判断今天
@property (nonatomic, readonly) BOOL xh_isToday;
// 判断明天
@property (nonatomic, readonly) BOOL xh_isTomorrow;
// 判断昨天
@property (nonatomic, readonly) BOOL xh_isYesterday;
// 判断前天
@property (nonatomic, readonly) BOOL xh_isBeforeYesterday;
// 上午||下午
@property (nonatomic, copy, readonly) NSString *xh_stringForTimeQuantum_CN;

/**
 判断是否是同一天
 
 @param aDate 一个时间
 @return 是否是同一天
 */
- (BOOL)xh_isSameDayAsDate:(NSDate *)aDate;

- (NSDate *)xh_dateByAddingDays:(NSInteger)days;
- (NSDate *)xh_dateBySubtractingDays:(NSInteger)days;

#pragma mark - week 相关
// 今天是周几，星期日为0，
@property (nonatomic, readonly) NSInteger xh_weekday;
// 在今年第几周
@property (nonatomic, readonly) NSInteger xh_weekNumber;
// 在今年第几周-中文
@property (nonatomic, copy, readonly) NSString *xh_weekNumber_CN;
// 这个月的第一天是星期几
@property (nonatomic, readonly) NSInteger xh_firstWeekdayInThisMonth;
// 星期几的中文显示
@property (nonatomic, copy, readonly) NSString *xh_stringForWeekDay_CN;
// 判断本周
@property (nonatomic, readonly) BOOL xh_isThisWeek;
// 判断工作日
@property (nonatomic, readonly) BOOL xh_isTypicallyWorkday;
// 判断周末
@property (nonatomic, readonly) BOOL xh_isTypicallyWeekend;

/**
 比较是否同一周

 @param aDate 一个时间
 @return 是否是同一天
 */
- (BOOL)xh_isSameWeekAsDate:(NSDate *)aDate;

- (NSDate *)xh_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)xh_dateBySubtractingWeeks:(NSInteger)weeks;

- (NSDate *)xh_getFirstDateOfWeek;
- (NSDate *)xh_getLastDateOfWeek;

#pragma mar - month 相关

// 这个月有多少天
@property (nonatomic, readonly) NSInteger xh_numberOfDaysInMonth;

/**
 是否是这个月
 */
@property (nonatomic, readonly) BOOL xh_isThisMonth;

/**
 比较时间是否在同一个月

 @param aDate 一个时间
 @return 是否在同一月
 */
- (BOOL)xh_isSameMonthAsDate:(NSDate *)aDate;

- (NSDate *)xh_dateByAddingMonths:(NSInteger)months;
- (NSDate *)xh_dateBySubtractingMonths:(NSInteger)months;

- (NSDate *)xh_getFirstDateOfMonth;
- (NSDate *)xh_getLastDateOfMonth;

#pragma mark - year 相关

/**
 是否是闰年
 */
@property (nonatomic, readonly) BOOL xh_isBissextile;

/**
 是否是今年
 */
@property (nonatomic, readonly) BOOL xh_isThisYear;

/**
 比较时间是否在同一个年

 @param aDate 一个时间
 @return 是否在同一年
 */
- (BOOL)xh_isSameYearAsDate:(NSDate *)aDate;

- (NSDate *)xh_dateByAddingYears:(NSInteger)years;
- (NSDate *)xh_dateBySubtractingYears:(NSInteger)years;


#pragma mark - 比较

/**
 时间比较

 @param aDate 一个时间
 @return NSOrderedSame 相同 NSOrderedAscending 之前 NSOrderedDescending 之后
 */
- (NSComparisonResult)xh_compareAsDate:(NSDate *)aDate;


#pragma mark - 中国农历和中文日期处理

// 中国农历 1 - 12
@property (nonatomic, assign, readonly) NSInteger xh_chineseYear;
@property (nonatomic, assign, readonly) NSInteger xh_chineseMonth;
@property (nonatomic, assign, readonly) NSInteger xh_chineseDay;

/**
 NSDateStringFormatCNValue1Style : 中文格式输出时间 今天 （今天 11：10）  昨天（昨天 10：11）  前天（前天 10：11）  今年：（01-11 11：10） 其他 (2016-01-11)
 NSDateStringFormatCNValue2Style : 中文格式输出时间 今天 （今天）  昨天（昨天）  前天（前天）  今年：（1月11） 其他 (2016年1月11日)
 @return 字符串
 */
- (NSString *)xh_stringFormatCN; //NSDateStringFormatCNValue1Style
- (NSString *)xh_stringFormatCNWithStyle:(NSDateStringFormatCNStyle)style;


@end
