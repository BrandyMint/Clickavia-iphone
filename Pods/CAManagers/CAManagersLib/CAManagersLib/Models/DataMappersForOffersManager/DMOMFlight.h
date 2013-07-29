//
//  DMOrderLight.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMOMFlight : NSObject
@property (strong,nonatomic) NSDate *departure_date;
@property (strong,nonatomic) NSString *departure_city;
@property (strong,nonatomic) NSDate *arrival_date;
@property (strong,nonatomic) NSString *arrival_city;
@property (strong,nonatomic) NSString *ID;
@end
