//
//  BookingManager.m
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "BookingManager.h"

@implementation BookingManager
- (void) bookFlight:(LoginForm *)byLogin withOrder:(Order *)order withComplete:(void (^)(BookingStatus *))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,ORDER_FLIGHT_ROUTE];
    NSString *authString = [[NSString alloc] initWithFormat:@"%@:%@",byLogin.email,byLogin.password];
    NSLog(@"Base64: %@",authString);
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
     {
         [request addHeader:@"Authorization" value:[[NSString alloc] initWithFormat:@"Basic %@",[authString base64String]]];
         [request addHeader:@"Content-Type" value:@"application/json"];
     }];
    DMBMOrder *dmorder = [self mapModelToDM:order];
    NSDictionary *jsonDictionary = [EKSerializer serializeObject:dmorder withMapping:[DMBMMappingProvider orderMapping]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"RequestBody: %@",requestBody);
    [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
    {
        if(response.status==200||response.status==201)
        {
            NSLog(@"%@",[response asString]);
            DMBMResponse *dmresponse = [self mapResponse:[response asString]];
            [self getManagerNameWithLogin:byLogin orderID:dmresponse.ID.stringValue andBlock:^(NSString *name)
            {
                BookingStatus *bookingStatus = [BookingStatus new];
                bookingStatus.order = order;
                if(name==nil)
                {
                    name = @"Неизвестно";
                }
                bookingStatus.managerName = name;
                bookingStatus.orderID = dmresponse.ID.stringValue;
                bookingStatus.state = dmresponse.state;
                block(bookingStatus);
            }];
        }
        else
        {
            NSLog(@"%@",[response asString]);
        }
    }];
}
- (DMBMResponse*)mapResponse:(NSString*) response
{
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    DMBMResponse *dmresponse = [EKMapper objectFromExternalRepresentation:jsonArray withMapping:[DMBMMappingProvider responseMapping]];
    return dmresponse;
}
- (DMBMOrder*)mapModelToDM:(Order*) order
{
    DMBMOrder *dmorder = [DMBMOrder new];
    dmorder.departure_flight_id = order.idRaceDeparture.stringValue;
    dmorder.return_flight_id = order.idRaceReturn.stringValue;
    dmorder.adults = order.adultsCount;
    if(order.adultsCount.intValue<1)
    {
        dmorder.adults = [[NSNumber alloc] initWithInt:1];
    }
    dmorder.children = order.childCount;
    if(order.childCount==nil)
    {
        dmorder.children = [[NSNumber alloc] initWithInt:0];
    }
    dmorder.infants = order.infantCount;
    if(order.infantCount==nil)
    {
        dmorder.infants = [[NSNumber alloc] initWithInt:0];
    }
    dmorder.payment_type_id = [[NSNumber alloc] initWithInteger:order.paymentType];
    NSMutableArray *array = [NSMutableArray new];
    for (PersonInfo *person in order.personsInfo)
    {
        DMBMPerson *dmperson = [[DMBMPerson alloc] initWith:person];
        [array addObject:dmperson];
    };
    dmorder.passports = array;
    return dmorder;
}
- (void)getManagerNameWithLogin:(LoginForm*)loginForm orderID:(NSString*)orderID andBlock:(void(^)(NSString *name))managerBlock;
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,ORDERS_ROUTE];
    NSString *authString = [[NSString alloc] initWithFormat:@"%@:%@",loginForm.email,loginForm.password];
    NSLog(@"Base64: %@",authString);
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
     {
         [request addHeader:@"Authorization" value:[[NSString alloc] initWithFormat:@"Basic %@",[authString base64String]]];
         
     }];
    [[LRResty client] get:url withBlock:^(LRRestyResponse *response)
     {
         if(response.status==200)
         {
             NSString *stringRepresentationOfReponse = [response asString];
             NSArray *ordersArray = [self mapOrders:stringRepresentationOfReponse];
             NSInteger i = ordersArray.count-1;
             
             NSString *managerName = [[NSString alloc] init];
             while(i>=0)
             {
                 DMOMOrder *dmorder = [ordersArray objectAtIndex:i];
                 if([dmorder.ID.stringValue isEqualToString:orderID])
                 {
                     managerName = dmorder.manager;
                     i = -1;
                 }
                 i--;
             }
             managerBlock(managerName);
         }
     }];
}
- (NSArray*) mapOrders:(NSString*) response
{
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *ordersArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMOMMappingProvider orderMapping]];
    return ordersArray;
}
@end
