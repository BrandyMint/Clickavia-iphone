//
//  BookingManager.h
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookingStatus.h"
#import "LoginForm.h"
#import "Order.h"
#import "Routes.h"
#import <LRResty/LRResty.h>
//#import <Base64/MF_Base64Additions.h>
#import "DMBMOrder.h"
#import "DMBMPerson.h"
#import "DMBMMappingProvider.h"
#import "DMBMResponse.h"
#import <EasyMapping/EasyMapping.h>
#import "OrdersManager.h"
#import "AuthManager.h"

@interface BookingManager : NSObject
- (void) bookFlight:(LoginForm*) byLogin withOrder:(Order*) order withComplete:(void(^)(BookingStatus* bookingStatus))block withFailed:(void(^)(NSException* exception)) failedBlock;
@end
