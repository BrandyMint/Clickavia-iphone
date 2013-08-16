//
//  DMObjectMapProtocol.h
//  CAManagersLib
//
//  Created by macmini1 on 17.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"
@protocol DMObjectMapProtocol <NSObject>
- (Destination*) toDestination;
@end
