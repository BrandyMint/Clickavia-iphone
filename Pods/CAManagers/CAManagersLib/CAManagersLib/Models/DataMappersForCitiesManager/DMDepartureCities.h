//
//  DMDepartureCities.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "DMObjectMapProtocol.h"

@interface DMDepartureCities : NSObject <DMObjectMapProtocol>

@property (strong,nonatomic) NSString *city_title;
@property (strong,nonatomic) NSString *city_iata;
@property (strong,nonatomic) NSArray *departure_airports;
+(RKObjectMapping*) createMapping;
-(Destination*) toDestination;
@end
