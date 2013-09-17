//
//  FlightDetails.m
//  clickavia-iphone
//
//  Created by bespalown on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderDetailsPersonal.h"


#define LABEL_AIRPORT_WIDTH 80
#define LABEL_COLUMN_DEPARTURE 100

@implementation CAOrderDetailsPersonal
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
    
    UILabel *numberZakaza = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    numberZakaza.backgroundColor = [UIColor clearColor];
    numberZakaza.textColor = [UIColor COLOR_PASSANGER_COUNT];
    numberZakaza.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    numberZakaza.text = @"Заказ №109537";
    [contenView addSubview:numberZakaza];
    [numberZakaza sizeToFit];

    UILabel *statusZakaza = [[UILabel alloc] initWithFrame:CGRectMake(numberZakaza.frame.origin.x + numberZakaza.frame.size.width + 10, numberZakaza.frame.origin.y, 0, 0)];
    statusZakaza.backgroundColor = [UIColor clearColor];
    statusZakaza.textColor = [UIColor greenColor];
    statusZakaza.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    statusZakaza.text = @"оплачен";
    [contenView addSubview:statusZakaza];
    [statusZakaza sizeToFit];
    
    UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(contenView.frame.size.width - 25, numberZakaza.frame.origin.y, 8, 10)];
    arrow.image = [UIImage imageNamed:@"toolbar-arrow-right@2x.png"];
    [contenView addSubview:arrow];

    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(arrow.frame.origin.x - 70, numberZakaza.frame.origin.y, 0, 0)];
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    detailsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    detailsLabel.text = @"подробно";
    [contenView addSubview:detailsLabel];
    [detailsLabel sizeToFit];
    
    [self createLineByBottom: numberZakaza.frame.origin.y + numberZakaza.frame.size.height + 5];

    UIView* passangersBlockView = [self flightPassengersBlockView:offerPassengers];
    passangersBlockView.frame = CGRectMake(contenView.frame.size.width - passangersBlockView.frame.size.width - 20,
                                           numberZakaza.frame.origin.y + numberZakaza.frame.size.height + 10,
                                           passangersBlockView.frame.size.width,
                                           passangersBlockView.frame.size.height);
    [contenView addSubview:passangersBlockView];
    
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectMake(passangersBlockView.frame.origin.x, passangersBlockView.frame.origin.y + passangersBlockView.frame.size.height + 5, 0, 0)];
    costLabel.backgroundColor = [UIColor clearColor];
    costLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    costLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    costLabel.text = @"стоимость";
    [costLabel sizeToFit];
    [contenView addSubview:costLabel];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(passangersBlockView.frame.origin.x, costLabel.frame.origin.y + costLabel.frame.size.height, 0, 0)];
    price.backgroundColor = [UIColor clearColor];
    price.textColor = [UIColor blackColor];
    price.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    price.text = [NSString stringWithFormat:@"%@ р.",offerObject.bothPrice];
    [contenView addSubview:price];
    [price sizeToFit];
    
     UIView *departFlightView = [self createFlightSubblock:YES];
     departFlightView.frame = CGRectMake(contenView.frame.origin.x, numberZakaza.frame.origin.y + numberZakaza.frame.size.height + 5, 100, 90);
     [self createLineByBottom:departFlightView.frame.origin.y + departFlightView.frame.size.height];
     
     UIView *returnFlightView = [self createFlightSubblock:NO];
     returnFlightView.frame = CGRectMake(departFlightView.frame.origin.x+departFlightView.frame.size.width, departFlightView.frame.origin.y, departFlightView.frame.size.width, departFlightView.frame.size.height);
     
     [contenView addSubview:departFlightView];
     [contenView addSubview:returnFlightView];
    
    UILabel *contactManagerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, departFlightView.frame.origin.y + departFlightView.frame.size.height + 10, 0, 0)];
    contactManagerLabel.backgroundColor = [UIColor clearColor];
    contactManagerLabel.textColor = [UIColor blackColor];
    contactManagerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    contactManagerLabel.text = @"Связаться с менеджером";
    [contenView addSubview:contactManagerLabel];
    [contactManagerLabel sizeToFit];

    
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
    
    UILabel *flightlabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 10, 5, 0, 0)];
    flightlabel.backgroundColor = [UIColor clearColor];
    flightlabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    flightlabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    flightlabel.text = (isDest)?@"рейс вылета":@"рейс возврата";
    [flightlabel sizeToFit];
    [subBlockView addSubview:flightlabel];
    
    UILabel *airportCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(flightlabel.frame.origin.x, flightlabel.frame.origin.y + flightlabel.frame.size.height + 5, 0, 0)];
    airportCodeLabel.backgroundColor = [UIColor clearColor];
    airportCodeLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airportCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airportCodeLabel];
    airportCodeLabel.text = (isDest)?[NSString stringWithFormat:@"%@ > %@",destinationDeparture.code, destinationReturn.code]:[NSString stringWithFormat:@"%@ > %@",destinationReturn.code, destinationDeparture.code];
    [airportCodeLabel sizeToFit];
    
    UILabel *dateFlightLabel = [[UILabel alloc] initWithFrame:CGRectMake(flightlabel.frame.origin.x, airportCodeLabel.frame.origin.y + airportCodeLabel.frame.size.height, 0, 0)];
    dateFlightLabel.backgroundColor = [UIColor clearColor];
    dateFlightLabel.textColor = [UIColor COLOR_LABEL_TIME];
    dateFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:dateFlightLabel];
    dateFlightLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.dateAndTimeDeparture]:[self dateToHHmm:flightReturnObject.dateAndTimeDeparture];
    [dateFlightLabel sizeToFit];
    
    UILabel *airportID = [[UILabel alloc] initWithFrame:CGRectMake(dateFlightLabel.frame.origin.x, dateFlightLabel.frame.origin.y + dateFlightLabel.frame.size.height, 0, 0)];
    airportID.backgroundColor = [UIColor clearColor];
    airportID.textColor = [UIColor COLOR_LABEL_TIME];
    airportID.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:airportID];
    airportID.text = (isDest)?flightDepartureObject.ID:flightReturnObject.ID;
    [airportID sizeToFit];

    return subBlockView;
}

-(void) createLineByBottom:(NSInteger)yBottom
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(contenView.frame.origin.x, yBottom, contenView.frame.size.width, 1)];
    line.backgroundColor = [UIColor COLOR_PASSANGER_COUNT];
    [contenView addSubview:line];
}

-(NSString* )dateToHHmm:(NSDate*)date
{
    NSDate * today = date;
    NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
    [date_format setDateFormat: @"dd.MM.YYYY"];
    NSString * date_string = [date_format stringFromDate: today];
    return date_string;
}

@end