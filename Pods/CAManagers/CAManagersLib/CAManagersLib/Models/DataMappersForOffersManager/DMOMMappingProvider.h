//
//  DMOMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMOMOrder.h"
#import "DMOMFlight.h"

@interface DMOMMappingProvider : NSObject
+ (EKObjectMapping*) orderMapping;
+ (EKObjectMapping*) orderFlightMapping;
@end
