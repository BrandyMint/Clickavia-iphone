//
//  MockDates.h
//  CAManagersLib
//
//  Created by macmini1 on 16.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACalendarMockDates : NSObject
+ (NSArray*)generateFlyToDates;
+ (NSArray*)generateFlyReturnDates:(NSDate*)flyToDate;
@end
