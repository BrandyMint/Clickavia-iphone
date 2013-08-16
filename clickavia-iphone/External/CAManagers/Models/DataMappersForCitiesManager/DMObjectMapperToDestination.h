//
//  DMObjectMapperToDestination.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"
#import "DMObjectMapProtocol.h"

@interface DMObjectMapperToDestination : NSObject
+(Destination*)mapFrom:(id<DMObjectMapProtocol>) dmObject;
@end
