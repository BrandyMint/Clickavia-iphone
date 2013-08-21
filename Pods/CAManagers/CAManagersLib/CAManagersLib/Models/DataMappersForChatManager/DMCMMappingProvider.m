//
//  DMCMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMCMMappingProvider.h"

@implementation DMCMMappingProvider
+ (EKObjectMapping*) messageMapping
{
    return [EKObjectMapping mappingForClass:[DMCMClientMessage class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"order_id" toField:@"order_id"];
                [mapping mapKey:@"text" toField:@"text"];
            }];
}
+ (EKObjectMapping*) chatMessageMapping
{
    return [EKObjectMapping mappingForClass:[DMCMChatMessage class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"type" toField:@"type"];
        [mapping mapKey:@"text" toField:@"text"];
        [mapping mapKey:@"user" toField:@"user"];
        [mapping mapKey:@"datetime" toField:@"datetime" withDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    }];
}
@end
