//
//  OrdersManager.m
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "OrdersManager.h"

@implementation OrdersManager

- (void) getOrders: (LoginForm*) loginForm completeBlock:(void(^)(NSArray *orders))block authFailedBlock:(void(^)(NSException *exception)) failedBlock
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
             block([self mapOrders:stringRepresentationOfReponse]);
         }
         else
         {
             NSException *exception = [[NSException alloc] initWithName:@"Authorization failed" reason:[[NSString alloc] initWithFormat:@"Response status %i",response.status] userInfo:nil];
             failedBlock(exception);
         }
         
     }];

}
- (NSArray*) mapOrders:(NSString*) response
{
    NSMutableArray *arrayOfOrders = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *ordersArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMOMMappingProvider orderMapping]];
    for (DMOMOrder *dmorder in ordersArray)
    {
        AcceptedOrder *order = [AcceptedOrder new];
        order.orderCode = dmorder.ID.stringValue;
        order.state = dmorder.status;
        if(dmorder.flights.count!=0)
        {
            DMOMFlight *flight = [dmorder.flights objectAtIndex:0];
            order.cityDeparture = flight.departure_city;
            order.cityArrival = flight.arrival_city;
            order.dateDeparture = flight.departure_date;
            order.dateArrival = flight.arrival_date;
        }
        [arrayOfOrders addObject:order];
        
    }
    return arrayOfOrders;
}
- (void) sendTicketsToEmail:(LoginForm*) loginForm byOrder:(AcceptedOrder*)byOrder
{

}
@end
