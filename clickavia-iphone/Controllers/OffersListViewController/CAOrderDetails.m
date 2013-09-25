//
//  OfferCellDetails.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderDetails.h"

#define LABEL_AIRPORT_TYPE_WIDTH 80
#define LABEL_COLUMN_DEPARTURE 100
#define LABEL_AIRPORT 120

@implementation CAOrderDetails
{
    Flight* flightDepartureObject;
    Flight* flightReturnObject;
    OfferConditions* offerConditions;
    SearchConditions* searchConditions;
    Destination* destinationDeparture;
    Destination* destinationReturn;
    
    UIView* contenView;
}

- (UIView*) initByOfferModel:(Offer*)offerObject passengers:(FlightPassengersCount*)offerPassengers;
{
    flightDepartureObject = [[Flight alloc] init];
    flightReturnObject = [[Flight alloc] init];
    offerConditions = [[OfferConditions alloc] init];
    searchConditions = [[SearchConditions alloc] init];
    destinationDeparture = [[Destination alloc] init];
    destinationReturn = [[Destination alloc] init];
    
    flightDepartureObject = offerObject.flightDeparture;
    flightReturnObject = offerObject.flightReturn;
    offerConditions = offerObject.offerConditions;
    searchConditions = offerConditions.searchConditions;
    destinationDeparture = searchConditions.direction_departure;
    destinationReturn = searchConditions.direction_return;
    
    contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    contenView.backgroundColor = [UIColor whiteColor];
    [contenView.layer setCornerRadius:6];
    
    UIView *departFlightView = [self createFlightSubblock:YES];
    departFlightView.frame = CGRectMake(contenView.frame.origin.x, 0, contenView.frame.size.width, 60);
    [self createLineByBottom: [self getBottom:departFlightView.frame]];
    
    UIView *returnFlightView = [self createFlightSubblock:NO];
    returnFlightView.frame = CGRectMake(contenView.frame.origin.x, [self getBottom:departFlightView.frame], contenView.frame.size.width, departFlightView.frame.size.height);
    [self createLineByBottom: [self getBottom:returnFlightView.frame]];
    
    [contenView addSubview:departFlightView];
    [contenView addSubview:returnFlightView];
    
    UIView* passangersBlockView = [self flightPassengersBlockView:offerPassengers];
    passangersBlockView.frame = CGRectMake(10,
                                           140,
                                           passangersBlockView.frame.size.width,
                                           passangersBlockView.frame.size.height);
    [contenView addSubview:passangersBlockView];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.size.width/2, returnFlightView.frame.origin.y + returnFlightView.frame.size.height + 10, 0, 0)];
    price.backgroundColor = [UIColor clearColor];
    price.textColor = [UIColor COLOR_PASSANGER_COUNT];
    price.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    price.text = [NSString stringWithFormat:@"%@ р.",offerObject.bothPrice];
    [contenView addSubview:price];
    [price sizeToFit];

    return contenView;
}

-(UIView*) flightPassengersBlockView:(FlightPassengersCount*)passangers;
{
    UIView* blockView = [[UIView alloc] init];
    
    UIImageView* adultsImage = [[UIImageView alloc] initWithFrame:CGRectMake(blockView.frame.origin.x, 0, 10, 26)];
    adultsImage.image = [UIImage imageNamed:@"passengers-icon-man@2x.png"];
    UILabel* adultsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(adultsImage.frame.origin.x + adultsImage.frame.size.width + 4, 4, 0, 0)];
    adultsCountLabel.backgroundColor = [UIColor clearColor];
    adultsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    adultsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    adultsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.adults];
    [adultsCountLabel sizeToFit];
    
    [blockView addSubview:adultsImage];
    [blockView addSubview:adultsCountLabel];
    
    UIImageView* kidsImage = [[UIImageView alloc] initWithFrame:CGRectMake(adultsCountLabel.frame.origin.x + adultsCountLabel.frame.size.width + 9, 3, 8, 20)];
    kidsImage.image = [UIImage imageNamed:@"passengers-icon-kid@2x.png"];
    UILabel* kidsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kidsImage.frame.origin.x + kidsImage.frame.size.width + 4, 4, 0, 0)];
    kidsCountLabel.backgroundColor = [UIColor clearColor];
    kidsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    kidsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    kidsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.kids];
    [kidsCountLabel sizeToFit];
    
    [blockView addSubview:kidsImage];
    [blockView addSubview:kidsCountLabel];
    
    UIImageView* babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(kidsCountLabel.frame.origin.x + kidsCountLabel.frame.size.width + 9, 4, 11, 18)];
    babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(babyImage.frame.origin.x + babyImage.frame.size.width + 4, 4, 0, 0)];
    babyiesCountLabel.backgroundColor = [UIColor clearColor];
    babyiesCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    babyiesCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    babyiesCountLabel.text = [NSString stringWithFormat:@"%d",passangers.babies];
    [babyiesCountLabel sizeToFit];
    
    [blockView addSubview:babyImage];
    [blockView addSubview:babyiesCountLabel];
    
    blockView.frame = CGRectMake(0, 0, babyiesCountLabel.frame.origin.x + babyiesCountLabel.frame.size.width, 30);
    return blockView;
}

-(UIView*) createFlightSubblock:(BOOL)isDest
{
    UIView *subBlockView = [[UIView alloc] init];
    
    UILabel *airlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 12, 5, 0, 0)];
    airlineTitleLabel.backgroundColor = [UIColor clearColor];
    airlineTitleLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airlineTitleLabel];
    airlineTitleLabel.text = (isDest)?flightDepartureObject.airportArrival:flightReturnObject.airportDeparture;
    [airlineTitleLabel sizeToFit];
    
    UILabel *airlineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(airlineTitleLabel.frame.origin.x + airlineTitleLabel.frame.size.width + 10, airlineTitleLabel.frame.origin.y + 1, LABEL_AIRPORT_TYPE_WIDTH, 14)];
    airlineCodeLabel.backgroundColor = [UIColor clearColor];
    airlineCodeLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    [subBlockView addSubview:airlineCodeLabel];
    airlineCodeLabel.text = (isDest)?flightDepartureObject.ID:flightReturnObject.ID;
    
    UILabel *dateFlight = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-10, airlineTitleLabel.frame.origin.y, 0, 0)];
    dateFlight.backgroundColor = [UIColor clearColor];
    dateFlight.textColor = [UIColor COLOR_PASSANGER_COUNT];
    dateFlight.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:dateFlight];
    dateFlight.text = (isDest)?@"23 апреля":@"24 апреля";
    [dateFlight sizeToFit];

    UILabel *timeDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(airlineTitleLabel.frame.origin.x, [self getBottom:airlineTitleLabel.frame], 0, 0)];
    timeDepartureLabel.backgroundColor = [UIColor clearColor];
    timeDepartureLabel.textColor = [UIColor COLOR_LABEL_TIME];
    timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeDepartureLabel];
    timeDepartureLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.dateAndTimeDeparture]:[self dateToHHmm:flightReturnObject.dateAndTimeDeparture];
    [timeDepartureLabel sizeToFit];
    
    UILabel *cityDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeDepartureLabel.frame.origin.x + timeDepartureLabel.frame.size.width + 10, [self getBottom:airlineTitleLabel.frame] + 2, LABEL_COLUMN_DEPARTURE, 14)];
    cityDepartureLabel.backgroundColor = [UIColor clearColor];
    cityDepartureLabel.textColor = [UIColor blackColor];
    cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityDepartureLabel];
    cityDepartureLabel.text = (isDest)?flightDepartureObject.cityDeparture:flightReturnObject.cityDeparture;
    
    UILabel *timeArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2, timeDepartureLabel.frame.origin.y, 0, 0)];
    timeArrivalLabel.backgroundColor = [UIColor clearColor];
    timeArrivalLabel.textColor = [UIColor COLOR_LABEL_TIME];
    timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeArrivalLabel];
    timeArrivalLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.dateAndTimeArrival]:[self dateToHHmm:flightReturnObject.dateAndTimeArrival];
    [timeArrivalLabel sizeToFit];
    
    UILabel *cityArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeArrivalLabel.frame.origin.x + timeArrivalLabel.frame.size.width + 10, cityDepartureLabel.frame.origin.y, LABEL_COLUMN_DEPARTURE, 14)];
    cityArrivalLabel.backgroundColor = [UIColor clearColor];
    cityArrivalLabel.textColor = [UIColor blackColor];
    cityArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityArrivalLabel];
    cityArrivalLabel.text = (isDest)?flightDepartureObject.cityArrival:flightReturnObject.cityArrival;
    
    UILabel *timeInFlightLabel = [[UILabel alloc] init];
    timeInFlightLabel.backgroundColor = [UIColor clearColor];
    timeInFlightLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    timeInFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:timeInFlightLabel];
    timeInFlightLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.timeInFlight]:[self dateToHHmm:flightReturnObject.timeInFlight];
    [timeInFlightLabel sizeToFit];
    timeInFlightLabel.frame = CGRectMake(contenView.frame.size.width-timeInFlightLabel.frame.size.width - 5, 7, timeInFlightLabel.frame.size.width, timeInFlightLabel.frame.size.height);
    
    UIImageView* clock = [[UIImageView alloc] initWithFrame:CGRectMake(contenView.frame.size.width-timeInFlightLabel.frame.size.width-30, 6, 15, 15)];
    clock.image = [UIImage imageNamed:@"clock-icon@2x.png"];
    [subBlockView addSubview:clock];
    
    UILabel *airportDeparture = [[UILabel alloc] initWithFrame:CGRectMake(airlineTitleLabel.frame.origin.x, [self getBottom:timeDepartureLabel.frame], LABEL_AIRPORT, 14)];
    airportDeparture.backgroundColor = [UIColor clearColor];
    airportDeparture.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airportDeparture.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airportDeparture];
    airportDeparture.text = (isDest)?[NSString stringWithFormat:@"%@, %@",destinationDeparture.airportTitle, destinationDeparture.code]:[NSString stringWithFormat:@"%@, %@",destinationReturn.airportTitle, destinationReturn.code];
    //[airportDeparture sizeToFit];
    
    UILabel *airportArrival = [[UILabel alloc] initWithFrame:CGRectMake(timeArrivalLabel.frame.origin.x, airportDeparture.frame.origin.y, LABEL_AIRPORT, 14)];
    airportArrival.backgroundColor = [UIColor clearColor];
    airportArrival.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airportArrival.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airportArrival];
    airportArrival.text = airportDeparture.text = (isDest)?[NSString stringWithFormat:@"%@, %@",destinationReturn.airportTitle, destinationReturn.code]:[NSString stringWithFormat:@"%@, %@",destinationDeparture.airportTitle, destinationDeparture.code];
    //[airportArrival sizeToFit];
    
    return subBlockView;
}

-(void) createLineByBottom:(NSInteger)yBottom
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(contenView.frame.origin.x, yBottom, contenView.frame.size.width, 1)];
    line.backgroundColor = [UIColor COLOR_PASSANGER_COUNT];
    [contenView addSubview:line];
}

-(NSInteger) getBottom:(CGRect)rect
{
    return rect.origin.y+rect.size.height + 1;
}

-(NSString* )dateToHHmm:(NSDate*)date
{
    NSDate * today = date;
    NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
    [date_format setDateFormat: @"HH:mm"];
    NSString * date_string = [date_format stringFromDate: today];
    return date_string;
}

@end
