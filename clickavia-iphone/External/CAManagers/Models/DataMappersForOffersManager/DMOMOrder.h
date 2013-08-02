//
//  DMOrderMapping.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EasyMapping.h>

@interface DMOMOrder : NSObject
@property (strong,nonatomic) NSNumber *ID;
@property (strong,nonatomic) NSArray *flights;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *manager;
@end
