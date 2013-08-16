//
//  DMPerson.h
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfo.h"

@interface DMBMPerson : NSObject
- (id) initWith:(PersonInfo*) personInfo;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *second_name;
@property (strong,nonatomic) NSString *first_name;
@property (strong,nonatomic) NSString *birthday;
@property (strong,nonatomic) NSString *series;
@property (strong,nonatomic) NSString *number;
@property (strong,nonatomic) NSString *expiration;
@end
