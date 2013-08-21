//
//  OrdersManager.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginForm.h"
#import "AcceptedOrder.h"
#import <LRResty/LRResty.h>
#import <EasyMapping/EasyMapping.h>
#import "Routes.h"
#import <Base64/MF_Base64Additions.h>
#import "DMOMMappingProvider.h"

@interface OrdersManager : NSObject
- (void) getOrders: (LoginForm*) loginForm completeBlock:(void(^)(NSArray *orders))block authFailedBlock:(void(^)(NSException *exception)) failedBlock;
- (void) sendTicketsToEmail:(LoginForm*) loginForm byOrder:(AcceptedOrder*)byOrder;
@end
