//
//  DMFDMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 27.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMFMFlight.h"
#import "DMFDMFullFlight.h"
#import <EasyMapping/EasyMapping.h>
@interface DMFDMMappingProvider : NSObject
+ (EKObjectMapping*) flightMapping;
+ (EKObjectMapping*) fullFlightMapping;
@end
