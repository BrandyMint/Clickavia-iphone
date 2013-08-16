//
//  DMAMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 23.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EasyMapping.h>
#import "User.h"
#import "LoginForm.h"

@interface DMAMMappingProvider : NSObject
+ (EKObjectMapping*) userMapping;
+ (EKObjectMapping*) authMapping;
@end
