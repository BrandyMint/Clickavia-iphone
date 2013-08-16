//
//  AuthManager.m
//  CAManagersLib
//
//  Created by macmini1 on 23.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "AuthManager.h"

@implementation AuthManager
- (void) getUser:(LoginForm *) withLoginForm completeBlock:(void (^) (User *user)) block  failBlock:(void (^) (NSException *exception)) blockException
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,AUTH_ROUTE];
    NSDictionary *jsonDictionary = [EKSerializer serializeObject:withLoginForm withMapping:[DMAMMappingProvider authMapping]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"RequestBody: %@",requestBody);
    
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request)
     {
         [request addHeader:@"Content-Type" value:@"application/json"];
     }];
    [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
     {
         NSString *stringRepresentationOfResponse = [response asString];
         if([stringRepresentationOfResponse isEqualToString:@"null"]||response.status!=201)
         {
             NSException *exception = [[NSException alloc] initWithName:@"Authentication is failed" reason:@"Check your password or email" userInfo:nil];
             blockException(exception);
         }
         else
         {
             NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
             User *user = [EKMapper objectFromExternalRepresentation:jsonArray withMapping:[DMAMMappingProvider userMapping]];
             block(user);
         }

     }];
}
@end
