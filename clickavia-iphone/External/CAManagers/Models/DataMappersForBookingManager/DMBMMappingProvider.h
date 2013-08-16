//
//  DMBMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMBMPerson.h"
#import "DMBMOrder.h"
#import <EasyMapping/EasyMapping.h>
#import "DMBMResponse.h"

@interface DMBMMappingProvider : NSObject
+ (EKObjectMapping*) personMapping;
+ (EKObjectMapping*) orderMapping;
+ (EKObjectMapping*) responseMapping;
@end
