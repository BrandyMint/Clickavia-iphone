//
//  DMFMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMFMFullFlight.h"

#import <EasyMapping/EasyMapping.h>

@interface DMFMMappingProvider : NSObject
+ (EKObjectMapping*) fullFlightMapping;
+ (EKObjectMapping*) flightMapping;

@end
