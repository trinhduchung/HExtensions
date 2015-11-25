//
//  NSDate+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSDate+HExtensions.h"

#define kMINUTE     60
#define kHOUR		3600
#define kDAY		86400
#define kWEEK		604800
#define kYEAR		31556926

static const unsigned kComponentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (HExtensions)

static NSCalendar *_sharedCalendar = nil;
static NSDateFormatter *_sharedDateFormatter = nil;

+ (NSCalendar *)currentCalendar {
    return [[self class] sharedCalendar];
}

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
        _sharedDateFormatter = [[NSDateFormatter alloc] init];
    });
}

+ (NSCalendar *)sharedCalendar {
    [self initializeStatics];
    
    return _sharedCalendar;
}

+ (NSDateFormatter *)sharedDateFormatter {
    [self initializeStatics];
    
    return _sharedDateFormatter;
}

@end

@implementation NSDate (DateString)

- (NSString *)shortString {
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortTimeString {
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortDateString {
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mediumString {
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumTimeString {
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumDateString {
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)longString {
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longTimeString {
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longDateString {
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[self class] sharedDateFormatter];
    [formatter setDateFormat:format];
    NSString *timestamp_str = [formatter stringFromDate:self];
    
    return timestamp_str;
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *formatter = [NSDate sharedDateFormatter];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;

    return [formatter stringFromDate:self];
}

@end

@implementation NSDate (DateCompare)

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSDate currentCalendar] components:kComponentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:kComponentFlags fromDate:aDate];
    
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSDate currentCalendar] components:kComponentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:kComponentFlags fromDate:aDate];
    
    return (components1.yearForWeekOfYear == components2.yearForWeekOfYear) && (components1.weekOfYear == components2.weekOfYear);
}

- (BOOL)isThisWeek {
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kWEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kWEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [self isSameWeekAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    
    return (componentsSelf.era == componentsArgs.era && componentsSelf.year == componentsArgs.year && componentsSelf.month == componentsArgs.month);
}

- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isLastMonth {
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL)isNextMonth {
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:aDate];
    
    return (componentsSelf.era == componentsArgs.era && componentsSelf.year == componentsArgs.year);
}

- (BOOL)isThisYear {
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear {
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isEarlierThanOrEqualDate:(NSDate *)aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    
    return (comparisonResult == NSOrderedAscending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isLaterThanOrEqualDate:(NSDate *)aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    
    return (comparisonResult == NSOrderedDescending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isInFuture {
    return ([self isLaterThanDate:[NSDate date]]);
}

- (BOOL)isInPast {
    return ([self isEarlierThanDate:[NSDate date]]);
}

@end

@implementation NSDate (DateAdjusting)

- (NSDate *)dateByAddingYears:(NSInteger)dYears {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[[self class] currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    
    return newDate;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)dYears {
    return [self dateByAddingYears:-dYears];
}

- (NSDate *)dateByAddingMonths:(NSInteger)dMonths {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[[self class] currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    
    return newDate;
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths {
    return [self dateByAddingMonths:-dMonths];
}

- (NSDate *)dateByAddingDays:(NSInteger) dDays {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dDays;
    NSCalendar *calendar = [NSDate currentCalendar];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays {
    return [self dateByAddingDays:-dDays];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = dHours;
    NSCalendar *calendar = [NSDate currentCalendar];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours {
    return [self dateByAddingHours:-dHours];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = dMinutes;
    NSCalendar *calendar = [NSDate currentCalendar];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes {
    return [self dateByAddingMinutes:-dMinutes];
}

- (NSDate *)dateAtStartOfDay {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.timeZone = calendar.timeZone;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    components.timeZone = calendar.timeZone;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfWeek
{
    NSDate *startOfWeek = nil;
    [[NSDate currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startOfWeek interval:NULL forDate:self];
    
    return startOfWeek;
}

- (NSDate *)dateAtEndOfWeek
{
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.day += [self numberOfDaysInWeek] - components.weekday;
    
    return [calendar dateFromComponents:components];
}
- (NSDate *)dateAtStartOfMonth {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.location;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfMonth {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.length;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfYear {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = dayRange.location;
    components.month = monthRange.location;
    NSDate *startOfYear = [calendar dateFromComponents:components];
    
    return startOfYear;
}

- (NSDate *)dateAtEndOfYear {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    components.month = monthRange.length;
    
    NSDate *endMonthOfYear = [calendar dateFromComponents:components];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:endMonthOfYear];
    components.day = dayRange.length;
    NSDate *endOfYear = [calendar dateFromComponents:components];
    
    return endOfYear;
}

@end

@implementation NSDate (DateRetrieving)

- (NSInteger)minutesAfterDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    
    return [components minute];
}

- (NSInteger)minutesBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMinute fromDate:self toDate:aDate options:0];
    
    return [components minute];
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    
    return [components hour];
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:self toDate:aDate options:0];
    
    return [components hour];
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
    
    return [components day];
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [components day];
}

- (NSInteger)monthsAfterDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMonth fromDate:aDate toDate:self options:0];
    
    return [components month];
}

- (NSInteger)monthsBeforeDate:(NSDate *)aDate {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:aDate options:0];
    
    return [components month];
}

- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    
    return [dateComponents day];
}

@end

@implementation NSDate (DateRelatives)

+ (NSDate *)dateTomorrow {
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours {
    return [[NSDate date] dateByAddingHours:dHours];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours {
    return [[NSDate date] dateBySubtractingHours:dHours];
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes {
    return [[NSDate date] dateByAddingMinutes:dMinutes];
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes {
    return [[NSDate date] dateBySubtractingMinutes:dMinutes];
}

@end

@implementation NSDate (DateComponents)

- (NSInteger)nearestHour {
    NSCalendar *calendar = [NSDate currentCalendar];
    NSRange minuteRange = [calendar rangeOfUnit:NSCalendarUnitMinute inUnit:NSCalendarUnitHour forDate:self];
    // always 30...
    NSInteger halfMinuteInHour = minuteRange.length / 2;
    NSInteger currentMinute = self.minute;
    if (currentMinute < halfMinuteInHour) {
        return self.hour;
    } else {
        NSDate *anHourLater = [self dateByAddingHours:1];
        return [anHourLater hour];
    }
}

- (NSInteger)hour {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:self];
    
    return [components hour];
}

- (NSInteger)minute {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    
    return [components minute];
}

- (NSInteger)seconds {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    
    return [components second];
}

- (NSInteger)day {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitDay fromDate:self];
    
    return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    
    return [components month];
}

- (NSInteger)week {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    
    return [components weekOfMonth];
}

- (NSInteger)weekday {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    
    return [components weekday];
}

// http://stackoverflow.com/questions/11681815/current-week-start-and-end-date
- (NSInteger)firstDayOfWeekday {
    NSDate *startOfTheWeek;
    NSTimeInterval interval;
    [[NSDate currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                   startDate:&startOfTheWeek
                                    interval:&interval
                                     forDate:self];
    
    return [startOfTheWeek day];
}

- (NSInteger)lastDayOfWeekday {
    return [self firstDayOfWeekday] + ([self numberOfDaysInWeek] - 1);
}

- (NSInteger)nthWeekday {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    
    return [components weekdayOrdinal];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    
    return [components year];
}

- (NSInteger)gregorianYear {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    
    return [components year];
}

- (NSInteger)numberOfDaysInWeek {
    return [[NSDate currentCalendar] maximumRangeOfUnit:NSCalendarUnitWeekday].length;
}

@end

