//
//  DMCMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMCMClientMessage.h"
#import <EasyMapping/EasyMapping.h>
#import "DMCMChatMessage.h"

@interface DMCMMappingProvider : NSObject
+ (EKObjectMapping*) messageMapping;
+ (EKObjectMapping*) chatMessageMapping;
@end
