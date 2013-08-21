//
//  PersonInfo.m
//  CAManagersLib
//
//  Created by macmini1 on 03.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "PersonInfo.h"

@implementation PersonInfo
 - (id) init
{
    self = [super init];
    if(self)
    {
        _birthDate = [NSDate date];
        _validDate = [NSDate date];
        _name = @"Имя";
        _lastName = @"Фамилия";
        _passportNumber = @"123456";
        _passportSeries = @"1234";
        _personType = male;
    }
    return self;
}
@end
