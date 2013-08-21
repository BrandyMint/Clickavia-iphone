//
//  PersonInfo.h
//  CAManagersLib
//
//  Created by macmini1 on 03.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    male,
    female,
    children,
    infant
} PersonType;

@interface PersonInfo : NSObject
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *name;
@property PersonType personType;
@property (strong,nonatomic) NSDate *birthDate;
@property (strong,nonatomic) NSDate *validDate;
@property (strong,nonatomic) NSString *passportSeries;
@property (strong,nonatomic) NSString *passportNumber;
@end
