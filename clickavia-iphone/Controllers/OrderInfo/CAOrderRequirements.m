//
//  CAOrderRequirements.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 20/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderRequirements.h"

@implementation CAOrderRequirements

- (UIView* )initWithRequirements:(flightType)flightType dateDeparture:(NSString *)dateDeparture dateArrival:(NSString *)dateArrival code:(NSString *)code{
    UIView* mainView = [UIView new];
    
    UILabel* airtortCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
    airtortCode.font = [UIFont systemFontOfSize:12];
    airtortCode.text = code;
    [airtortCode sizeToFit];
    [mainView addSubview:airtortCode];
    
    UILabel* service = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 0, 0)];
    service.font = [UIFont systemFontOfSize:12];
    service.text = @"Уровень сервиса";
    [service sizeToFit];
    [mainView addSubview:service];
    
    NSString* flightTypeString = @"";
    switch (flightType) {
        case econom:
            flightTypeString = @"ECONOM";
            break;
        case business:
            flightTypeString = @"BUSINESS";
            break;
        default:
            break;
    }
    
    UILabel* serviceInfo = [[UILabel alloc] initWithFrame:CGRectMake(service.frame.origin.x + service.frame.size.width + 3, 0, 0, 0)];
    serviceInfo.text = flightTypeString;
    serviceInfo.font = [UIFont systemFontOfSize:12];
    [serviceInfo sizeToFit];
    [mainView addSubview:serviceInfo];
    
    UILabel* departure = [[UILabel alloc] initWithFrame:CGRectMake(10, [self getBottom:serviceInfo.frame], 0, 0)];
    departure.text = @"отправление";
    departure.font = [UIFont systemFontOfSize:12];
    [departure sizeToFit];
    [mainView addSubview:departure];
    
    UILabel* departureInfo = [[UILabel alloc] initWithFrame:CGRectMake(departure.frame.origin.x + departure.frame.size.width + 3, [self getBottom:serviceInfo.frame], 0, 0)];
    departureInfo.text = dateDeparture;
    departureInfo.font = [UIFont systemFontOfSize:12];
    [departureInfo sizeToFit];
    [mainView addSubview:departureInfo];
    
    if (dateArrival != nil) {
        UILabel* arrival = [[UILabel alloc] initWithFrame:CGRectMake(160, [self getBottom:serviceInfo.frame], 0, 0)];
        arrival.text = @"прибытие";
        arrival.font = [UIFont systemFontOfSize:12];
        [arrival sizeToFit];
        [mainView addSubview:arrival];
        
        UILabel* arrivalInfo = [[UILabel alloc] initWithFrame:CGRectMake(arrival.frame.origin.x + arrival.frame.size.width + 3, [self getBottom:serviceInfo.frame], 0, 0)];
        arrivalInfo.text = dateArrival;
        arrivalInfo.font = [UIFont systemFontOfSize:12];
        [arrivalInfo sizeToFit];
        [mainView addSubview:arrivalInfo];
    }

    mainView.frame = CGRectMake(0, 0, 320, [self getBottom:departure.frame]);
    
    return mainView;
}

-(NSInteger) getBottom:(CGRect)rect
{
    return rect.origin.y+rect.size.height + 5;
}

@end
