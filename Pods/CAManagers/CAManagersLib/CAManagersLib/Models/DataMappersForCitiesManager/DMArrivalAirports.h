//
//  DMArrivalAirports.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKit/RestKit.h"
#import "DMObjectMapProtocol.h"

@interface DMArrivalAirports : NSObject<DMObjectMapProtocol>
@property (strong,nonatomic) NSString* airport_iata;
@property (strong,nonatomic) NSString* airport_title;
+(RKObjectMapping*) createMapping;
-(Destination*) toDestination;
@end
