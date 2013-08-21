//
//  DMDepartureCoutry.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "DMObjectMapProtocol.h"

@interface DMDepartureCountry : NSObject<DMObjectMapProtocol>
@property (strong,nonatomic) NSString *departure_country_title;
@property (strong,nonatomic) NSString *departure_country_iata;
@property (strong,nonatomic) NSArray *departure_cities;
+(RKObjectMapping*) createMapping;
- (Destination*) toDestination;
@end
