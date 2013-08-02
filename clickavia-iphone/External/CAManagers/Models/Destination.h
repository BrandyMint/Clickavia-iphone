//
//  Destination.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    city,
    airport,
    country
} DestinationType;

@interface Destination : NSObject
{
}
@property (strong,nonatomic) NSString* title;
@property (strong,nonatomic) NSString* code;
@property DestinationType destinationType;
@property (strong,nonatomic) NSString* cityCode;
@property (strong,nonatomic) NSString* countryTitle;
@property (strong,nonatomic) NSString* cityTitle;
@property (strong,nonatomic) NSString* airportTitle;
@end
