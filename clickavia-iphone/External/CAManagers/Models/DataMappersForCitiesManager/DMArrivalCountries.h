//
//  DMArrivalCountries.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "DMObjectMapProtocol.h"

@interface DMArrivalCountries : NSObject<DMObjectMapProtocol>
@property (strong,nonatomic) NSString *country_title;
@property (strong,nonatomic) NSString *country_iata;
@property (strong,nonatomic) NSArray *arrival_cities;
+(RKObjectMapping*) createMapping;
-(Destination*) toDestination;
@end
