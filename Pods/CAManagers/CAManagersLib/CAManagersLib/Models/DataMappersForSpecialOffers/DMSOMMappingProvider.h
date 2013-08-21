//
//  DMSOMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMSOMFlight.h"
#import "DMSOMCountry.h"
#import "DMSOMOffer.h"
#import "DMSOMCountry.h"
#import "DMSOMCity.h"

#import <EasyMapping/EasyMapping.h>

@interface DMSOMMappingProvider : NSObject
+ (EKObjectMapping*) flightMapping;
+ (EKObjectMapping*) offerMapping;
+ (EKObjectMapping*) countryMapping;
+ (EKObjectMapping*) cityMapping;
@end
