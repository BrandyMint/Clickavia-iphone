//
//  BookingStatus.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
@interface BookingStatus : NSObject
@property (strong,nonatomic) Order *order;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *managerName;
@property (strong,nonatomic) NSString *orderID;
@end
