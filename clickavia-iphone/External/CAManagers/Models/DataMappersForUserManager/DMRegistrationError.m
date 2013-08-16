//
//  DMRegistrationError.m
//  CAManagersLib
//
//  Created by macmini1 on 01.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMRegistrationError.h"

@implementation DMRegistrationError
- (BOOL) isError
{
    return (_name.count!=0)||(_phone_number.count!=0)||(_email.count!=0)||(_password.count!=0)||(_country_code.count!=0);
}
- (NSString*) errorMessage
{
    NSMutableString *message = [NSMutableString new];
    for (NSString *str in _name)
    {
        [message appendFormat:@"Error with name: %@\n",str];
    }
    for (NSString *str in _email)
    {
        [message appendFormat:@"Error with email: %@\n",str];
    }
    for (NSString *str in _password)
    {
        [message appendFormat:@"Error with password %@\n",str];
    }
    for (NSString *str in _country_code)
    {
        [message appendFormat:@"Error with country code %@\n",str];
    }
    for (NSString *str in _phone_number)
    {
        [message appendFormat:@"Error with phone number %@\n",str];
    }
    return message;
}
@end
