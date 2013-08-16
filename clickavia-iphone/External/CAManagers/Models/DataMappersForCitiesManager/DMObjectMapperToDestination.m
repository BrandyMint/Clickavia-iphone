//
//  DMObjectMapperToDestination.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMObjectMapperToDestination.h"

@implementation DMObjectMapperToDestination
+(Destination*)mapFrom:(id<DMObjectMapProtocol>)dmObject
{
    return [dmObject toDestination];
}
@end
