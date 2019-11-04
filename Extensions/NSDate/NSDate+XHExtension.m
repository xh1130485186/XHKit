//
//  NSDate+XHExtension.m
//  日历选择器
//
//  Created by 向洪 on 16/6/30.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "NSDate+XHExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSDate (XHExtension)

#pragma mark - 初始化
+ (instancetype)xh_dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)xh_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}


+ (instancetype)xh_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [calendar dateFromComponents:components];
}

#pragma mark - 按格式转字符串

- (NSString *)xh_stringWithformat:(NSString *)format {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

#pragma mark - 日期属性

- (NSInteger)xh_second {
    
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitSecond fromDate:self];
    return [components second];
}

- (NSInteger)xh_minute {
    
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitMinute fromDate:self];
    return [components minute];
}

- (NSInteger)xh_hour {
    
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSInteger)xh_day {
    
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)xh_month {
    
    NSDateComponents *component = [[NSCalendar currentCalendar]components:NSCalendarUnitMonth fromDate:self];
    return [component month];
}

- (NSInteger)xh_year {
    
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return [component year];
}

#pragma mark - day相关

- (BOOL)xh_isToday {
    
    return [self xh_isSameDayAsDate:[NSDate new]];
}

- (BOOL)xh_isTomorrow {
    
    NSDate *data = [NSDate new];
    NSDate *tomorrowDate = [data xh_dateByAddingDays:1];
    return [self xh_isSameDayAsDate:tomorrowDate];
}

- (BOOL)xh_isYesterday {
    
    NSDate *data = [NSDate new];
    NSDate *yesterdayDate = [data xh_dateBySubtractingDays:1];
    return [self xh_isSameDayAsDate:yesterdayDate];
}

- (BOOL)xh_isBeforeYesterday {
    
    NSDate *data = [NSDate new];
    NSDate *yesterdayDate = [data xh_dateBySubtractingDays:2];
    return [self xh_isSameDayAsDate:yesterdayDate];
}

- (BOOL)xh_isSameDayAsDate:(NSDate *)aDate {
    
    if (!aDate)
    {
        return NO;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:aDate];
    NSDate *otherDate = [calendar dateFromComponents:components];
    if([today isEqualToDate:otherDate])
    {
        return YES;
    }
    return NO;
}

- (NSString *)xh_stringForTimeQuantum_CN {
    
    if ([self xh_hour] >= 12) {
        return @"下午";
    } else {
        return @"上午";
    }
}

- (NSDate *)xh_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)xh_dateBySubtractingDays:(NSInteger)days
{
    return [self xh_dateByAddingDays:-days];
}

#pragma mark - week 相关

- (NSInteger)xh_weekday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal fromDate:self];
    return component.weekday - 1;
}

- (NSInteger)xh_weekNumber {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSString *)xh_weekNumber_CN {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:[self xh_weekNumber]]];
    return [NSString stringWithFormat:@"第%@周", string];
}

- (NSInteger)xh_firstWeekdayInThisMonth {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [component setDay:1];
    NSDate *firstDayofMonthDate = [calendar dateFromComponents:component];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayofMonthDate];
    return firstWeekday;
}

- (NSString *)xh_stringForWeekDay_CN {
    NSArray *array = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    return array[[self xh_weekday]];
    
}

- (BOOL)xh_isThisWeek {
    
    return [self xh_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)xh_isTypicallyWorkday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitWeekOfYear|NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:self];
    return (components1.weekday != 1 && components1.weekday != 6);
    
}

- (BOOL)xh_isTypicallyWeekend {
    
    return ![self xh_isTypicallyWorkday];
}

- (BOOL)xh_isSameWeekAsDate:(NSDate *)aDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitWeekOfYear|NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitWeekOfYear|NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:aDate];
    
    return (components1.weekOfYear == components2.weekOfYear && components1.year == components2.year);
}

- (NSDate *)xh_dateByAddingWeeks:(NSInteger)weeks {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
    
}
- (NSDate *)xh_dateBySubtractingWeeks:(NSInteger)weeks {
    
    return [self xh_dateByAddingWeeks:-weeks];
}

- (NSDate *)xh_getFirstDateOfWeek {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    NSInteger weekday = [components weekday];
    NSInteger numbersOfFirst;
    if (weekday == 1) { numbersOfFirst = -6; }
    else { numbersOfFirst =  - weekday + 2; }
    
    NSInteger day = [components day];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    [dateComponents setDay:day+numbersOfFirst];
    
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

- (NSDate *)xh_getLastDateOfWeek {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    NSInteger weekday = [components weekday];
    NSInteger numbersOfLast;
    if (weekday == 1) { numbersOfLast = 0; }
    else { numbersOfLast = 8 - weekday; }
    
    NSInteger day = [components day];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    [dateComponents setDay:day+numbersOfLast];
    
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    return newDate;
}

#pragma mar - month 相关

- (NSInteger)xh_numberOfDaysInMonth {
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

- (BOOL)xh_isThisMonth {
    
    return [self xh_isSameMonthAsDate:[NSDate new]];
}

- (BOOL)xh_isSameMonthAsDate:(NSDate *)aDate {
    
    return (self.xh_year == aDate.xh_year && self.xh_month == self.xh_month);
}

- (NSDate *)xh_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)xh_dateBySubtractingMonths:(NSInteger)months
{
    return [self xh_dateByAddingMonths:-months];
}


- (NSDate *)xh_getFirstDateOfMonth {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.xh_year;
    components.month = self.xh_month;
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)xh_getLastDateOfMonth {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.xh_year;
    components.month = self.xh_month;
    components.day = self.xh_numberOfDaysInMonth;
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [calendar dateFromComponents:components];
}
#pragma mark - year 相关

- (BOOL)xh_isBissextile {
    
    NSInteger year = self.xh_year;
    return ((year%4==0 && year %100 !=0) || year%400==0);
}

- (BOOL)xh_isThisYear {
    
    return [self xh_isSameYearAsDate:[NSDate date]];
}

- (BOOL)xh_isSameYearAsDate:(NSDate *)aDate {
    
    return (self.xh_year == aDate.xh_year);
}

- (NSDate *)xh_dateByAddingYears:(NSInteger)years {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)xh_dateBySubtractingYears:(NSInteger)years {
    
    return [self xh_dateByAddingYears:-years];
}

#pragma mark - 比较

- (NSComparisonResult)xh_compareAsDate:(NSDate *)aDate {
    
    NSTimeInterval time = [self timeIntervalSinceDate:aDate];
    if (time < 0) {
        return NSOrderedAscending;
    } else if (time > 0) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

#pragma mark - 中国农历和中文日期处理

- (NSInteger)xh_chineseYear {
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}


- (NSInteger)xh_chineseMonth {
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)xh_chineseDay {
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear fromDate:self];
    return components.day;
    
}

- (NSString *)xh_stringFormatCN {

    return [self xh_stringFormatCNWithStyle:NSDateStringFormatCNValue1Style];
}

- (NSString *)xh_stringFormatCNWithStyle:(NSDateStringFormatCNStyle)style {

    NSDate *date = [NSDate date];
    
    if (date.xh_year == self.xh_year) {
        
        if (date.xh_day == self.xh_day) {
            switch (style) {
                case NSDateStringFormatCNValue1Style:
                    return [NSString stringWithFormat:@"今天 %@", [self xh_stringWithformat:@"HH:mm"]];
                    break;
                case NSDateStringFormatCNValue2Style:
                    return @"今天";
                    break;
                    
                default:
                    break;
            }
    
        } else if (date.xh_day - self.xh_day == 1) {
            
            switch (style) {
                case NSDateStringFormatCNValue1Style:
                    return [NSString stringWithFormat:@"昨天 %@", [self xh_stringWithformat:@"HH:mm"]];
                    break;
                case NSDateStringFormatCNValue2Style:
                    return @"昨天";
                    break;
                    
                default:
                    break;
            }
            
        } else if (date.xh_day - self.xh_day == 2) {
            
            switch (style) {
                case NSDateStringFormatCNValue1Style:
                    return [NSString stringWithFormat:@"前天 %@", [self xh_stringWithformat:@"HH:mm"]];
                    break;
                case NSDateStringFormatCNValue2Style:
                    return @"前天";
                    break;
                    
                default:
                    break;
            }

        }
        switch (style) {
            case NSDateStringFormatCNValue1Style:
                return [self xh_stringWithformat:@"MM-dd HH:mm"];
                break;
            case NSDateStringFormatCNValue2Style:
                return [self xh_stringWithformat:@"MM月dd日"];
                break;
                
            default:
                break;
        }
        
        
    } else {
        
        return [self xh_stringWithformat:@"yyyy年MM月dd日"];
    }
}

@end
