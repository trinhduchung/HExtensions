//
//  NSDate+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HExtensions)
+ (NSCalendar *)currentCalendar;
@end

@interface NSDate (DateString)
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;
- (NSString *)dateStringWithFormat:(NSString *)format;
@end

@interface NSDate (DateCompare)
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL)isEarlierThanOrEqualDate:(NSDate *)aDate;
- (BOOL)isLaterThanOrEqualDate:(NSDate *)aDate;

- (BOOL)isInFuture;
- (BOOL)isInPast;
@end

@interface NSDate (DateAdjusting)
- (NSDate *)dateByAddingYears:(NSInteger)dYears;
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtEndOfDay;
- (NSDate *)dateAtStartOfWeek;
- (NSDate *)dateAtEndOfWeek;
- (NSDate *)dateAtStartOfMonth;
- (NSDate *)dateAtEndOfMonth;
- (NSDate *)dateAtStartOfYear;
- (NSDate *)dateAtEndOfYear;
@end

@interface NSDate (DateRetrieving)
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;
@end

@interface NSDate (DateRelatives)
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;
@end

@interface NSDate (DateComponents)
@property(readonly) NSInteger nearestHour;
@property(readonly) NSInteger hour;
@property(readonly) NSInteger minute;
@property(readonly) NSInteger seconds;
@property(readonly) NSInteger day;
@property(readonly) NSInteger month;
@property(readonly) NSInteger week;
//  in the Gregorian calendar, n is 7 and Sunday is represented by 1.
@property(readonly) NSInteger weekday;
@property(readonly) NSInteger firstDayOfWeekday;
@property(readonly) NSInteger lastDayOfWeekday;
// e.g. 2nd Tuesday of the month == 2
@property(readonly) NSInteger nthWeekday;
@property(readonly) NSInteger year;
@property(readonly) NSInteger gregorianYear;

- (NSInteger)numberOfDaysInWeek;

@end

