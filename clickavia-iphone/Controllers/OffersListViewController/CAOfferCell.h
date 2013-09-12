//
//  CAOfferCell.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CAManagers/Offer.h>
#import "Offer.h"
#import "Flight.h"
#import "FlightPassengersCount.h"
#import "CAOffersData.h"

#define CELL_HEIGHT_NORMAL 150
#define CELL_HEIGHT_SPECIAL 180

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
@property (nonatomic, retain) CAOffersData* caoffersData;

@property (nonatomic) BOOL isSpecial;
@property (nonatomic) BOOL isMomentaryConfirmation;
@property (nonatomic, strong) NSString *airlineTitle;
@property (nonatomic, strong) NSString *airlineCode;
@property (nonatomic, strong) NSDate *timeDeparture;
@property (nonatomic, strong) NSString *cityDeparture;
@property (nonatomic, strong) NSDate *timeArrival;
@property (nonatomic, strong) NSString *cityArrival;
@property (nonatomic, strong) NSDate *timeInFlight;
@property (nonatomic) NSUInteger *adultCount;
@property (nonatomic) NSUInteger *kidCount;
@property (nonatomic) NSUInteger *babuCount;

-(void) initByOfferModel:(Offer*)offer;

@end
