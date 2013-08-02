//
//  DMPerson.m
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMBMPerson.h"

@implementation DMBMPerson
- (id) initWith:(PersonInfo *)personInfo
{
    self  = [super init];
    if(self)
    {
        switch (personInfo.personType)
        {
            case male:
                _title = @"MR";
                break;
            case female:
                _title = @"MRS";
                break;
            case infant:
                _title = @"INF";
                break;
            case children:
                _title = @"CHD";
            default:
                _title = @"MR";
                break;
        };
        _first_name = personInfo.name;
        _second_name = personInfo.lastName;
        _series = personInfo.passportSeries;
        _number = personInfo.passportNumber;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        _birthday = [dateFormatter stringFromDate:personInfo.birthDate];
        _expiration = [dateFormatter stringFromDate:personInfo.validDate];
    }
    return self;
}
@end
