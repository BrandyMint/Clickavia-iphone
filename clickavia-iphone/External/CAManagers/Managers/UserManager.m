//
//  UserManager.m
//  CAManagersLib
//
//  Created by macmini1 on 28.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
- (void)getCountryCodes:(void (^)(NSArray *))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,COUNTRY_CODE_ROUTE];
    [[LRResty client] get:url withBlock:^(LRRestyResponse *response)
    {
        NSString *stringRepresentationOfReponse = [response asString];
        block([self mapCountryCodes:stringRepresentationOfReponse]);
    }];
}
- (NSArray *)mapCountryCodes:(NSString*)response
{
    NSArray *codes = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    codes = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMUMMappingProvider countryCodeMapping]];
    return codes;
}
-(void) registrateUser:(RegistrationForm *)withRegistrationForm completeBlock:(void (^)(User *))block failBlock:(void (^)(NSException *))blockException
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,REGISTRATION_ROUTE];
    NSDictionary *jsonDictionary = [EKSerializer serializeObject:withRegistrationForm withMapping:[DMUMMappingProvider registrationFormMapping]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[LRResty client] attachRequestModifier:^(LRRestyRequest *request) {
        [request addHeader:@"Content-Type" value:@"application/json"];
        
    }];
    [[LRResty client] post:url payload:requestBody withBlock:^(LRRestyResponse *response)
     {
         NSString *responseString = [response asString];
         NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
         DMRegistrationResponse *regResponse = [EKMapper objectFromExternalRepresentation:jsonArray withMapping:[DMUMMappingProvider registrationResponseMapping]];
         User *regUser = [User new];
         if(regResponse.errors.isError)
         {
             NSException *exception = [[NSException alloc] initWithName:@"Registration error" reason:[regResponse.errors errorMessage] userInfo:nil];
             blockException(exception);
         }
         else
         {
             regUser.email = withRegistrationForm.email;
             regUser.name = withRegistrationForm.name;
             regUser.phoneNumber = withRegistrationForm.phoneNumber;
             block(regUser);
         }
         
     }];
}
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
         if(response.status==200)
         {
             NSString *stringRepresentationOfResponse = [response asString];
             NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
             User *user = [EKMapper objectFromExternalRepresentation:jsonArray withMapping:[DMAMMappingProvider userMapping]];
             block(user);
         }
         else
         {
             NSException *exception = [[NSException alloc] initWithName:@"Authorization error" reason:@"Password or email is incorrect" userInfo:nil];
             blockException(exception);
         }
     }];
}
@end
