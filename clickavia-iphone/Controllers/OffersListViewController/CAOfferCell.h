//
//  CAOfferCell.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CAManagers/Offer.h>

#define CELL_HEIGHT_NORMAL 60
#define CELL_HEIGHT_SPECIAL 80

typedef enum {
    kAirlineTitle = 1,
    kAirlineCode,
    kTimeDeparture,
    kCityDeparture,
    kTimeArrival,
    kCityArrival,
    kTimeInFlight
} FlightBlock;

@interface CAOfferCell : UITableViewCell

-(void) initByOfferModel:(Offer*)offer;

@end
