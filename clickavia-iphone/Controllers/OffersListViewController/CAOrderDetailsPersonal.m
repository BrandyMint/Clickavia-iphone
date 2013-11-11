//
//  FlightDetails.m
//  clickavia-iphone
//
//  Created by bespalown on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderDetailsPersonal.h"

#define MARGIN_VIEW 5
#define LABEL_AIRPORT_WIDTH 80
#define LABEL_COLUMN_DEPARTURE 100

@implementation CAOrderDetailsPersonal
{
    UIView* contenView;
    SpecialOffer* specialOffer;
}

- (UIView*) initByOfferModel:(SpecialOffer*)specialOfferData passengers:(CAFlightPassengersCount*)offerPassengersData;
{
    specialOffer = [SpecialOffer new];
    specialOffer = specialOfferData;
    
    contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    contenView.backgroundColor = [UIColor whiteColor];
    [contenView.layer setCornerRadius:6];
    
    [self createLineByBottom: 0];
    
    UIView* passangersBlockView = [self flightPassengersBlockView:offerPassengersData];
    passangersBlockView.frame = CGRectMake(contenView.frame.size.width - passangersBlockView.frame.size.width - MARGIN_VIEW,
                                           10,
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
    
    UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(passangersBlockView.frame.origin.x, costLabel.frame.origin.y + costLabel.frame.size.height, 0, 0)];
    pricelabel.backgroundColor = [UIColor clearColor];
    pricelabel.textColor = [UIColor blackColor];
    pricelabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    pricelabel.text = [[NSString alloc] initWithFormat:@"%.0f р.", specialOfferData.price.floatValue];
    [contenView addSubview:pricelabel];
    [pricelabel sizeToFit];
    
    UIView *departFlightView = [self createFlightSubblock:YES];
    departFlightView.frame = CGRectMake(contenView.frame.origin.x, MARGIN_VIEW, contenView.frame.size.width/3*2, 90);
    [self createLineByBottom:departFlightView.frame.origin.y + departFlightView.frame.size.height];
    [contenView addSubview:departFlightView];
    
    if (specialOffer.isReturn) {
        CGRect departFlightFrame = departFlightView.frame;
        departFlightFrame.size.width = contenView.frame.size.width/3;
        departFlightView.frame = departFlightFrame;
        
        UIView *returnFlightView = [self createFlightSubblock:NO];
        returnFlightView.frame = CGRectMake(departFlightView.frame.origin.x+departFlightView.frame.size.width, departFlightView.frame.origin.y,departFlightView.frame.size.width, departFlightView.frame.size.height);
        [contenView addSubview:returnFlightView];
    }
    
    return contenView;
}

-(UIView*) flightPassengersBlockView:(CAFlightPassengersCount*)passangers;
{
    UIView* blockView = [[UIView alloc] init];
    
    UIImageView* adultsImage = [[UIImageView alloc] initWithFrame:CGRectMake(blockView.frame.origin.x, 0, 10, 26)];
    adultsImage.image = [UIImage imageNamed:@"passengers-icon-man@2x.png"];
    UILabel* adultsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(adultsImage.frame.origin.x + adultsImage.frame.size.width + 4, 4, 0, 0)];
    adultsCountLabel.backgroundColor = [UIColor clearColor];
    adultsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    adultsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    adultsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.adultsCount];
    [adultsCountLabel sizeToFit];
    
    [blockView addSubview:adultsImage];
    [blockView addSubview:adultsCountLabel];
    
    UIImageView* kidsImage = [[UIImageView alloc] initWithFrame:CGRectMake(adultsCountLabel.frame.origin.x + adultsCountLabel.frame.size.width + 9, 3, 8, 20)];
    kidsImage.image = [UIImage imageNamed:@"passengers-icon-kid@2x.png"];
    UILabel* kidsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kidsImage.frame.origin.x + kidsImage.frame.size.width + 4, 4, 0, 0)];
    kidsCountLabel.backgroundColor = [UIColor clearColor];
    kidsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    kidsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    kidsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.childrenCount];
    [kidsCountLabel sizeToFit];
    
    [blockView addSubview:kidsImage];
    [blockView addSubview:kidsCountLabel];
    
    UIImageView* babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(kidsCountLabel.frame.origin.x + kidsCountLabel.frame.size.width + 9, 4, 11, 18)];
    babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(babyImage.frame.origin.x + babyImage.frame.size.width + 4, 4, 0, 0)];
    babyiesCountLabel.backgroundColor = [UIColor clearColor];
    babyiesCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    babyiesCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    babyiesCountLabel.text = [NSString stringWithFormat:@"%d",passangers.infantsCount];
    [babyiesCountLabel sizeToFit];
    
    [blockView addSubview:babyImage];
    [blockView addSubview:babyiesCountLabel];
    
    blockView.frame = CGRectMake(0, 0, babyiesCountLabel.frame.origin.x + babyiesCountLabel.frame.size.width, 30);
    return blockView;
}

-(UIView*) createFlightSubblock:(BOOL)isDest
{
    UIView *subBlockView = [[UIView alloc] init];
    
    NSArray* dates = specialOffer.dates;
    NSArray* flightIds = specialOffer.flightIds;
    
    UILabel *flightlabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 10, 5, 0, 0)];
    flightlabel.backgroundColor = [UIColor clearColor];
    flightlabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    flightlabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    flightlabel.text = (isDest)?@"рейс вылета":@"рейс возврата";
    [flightlabel sizeToFit];
    [subBlockView addSubview:flightlabel];
    
    UILabel *airportCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(flightlabel.frame.origin.x,
                                                                          flightlabel.frame.origin.y + flightlabel.frame.size.height + 5,
                                                                          contenView.frame.size.width/3,
                                                                          14)];
    airportCodeLabel.backgroundColor = [UIColor clearColor];
    airportCodeLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airportCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airportCodeLabel];
    airportCodeLabel.text = (isDest)?[NSString stringWithFormat:@"%@ > %@",specialOffer.flightCity, specialOffer.departureCity]:[NSString stringWithFormat:@"%@ > %@",specialOffer.flightCity, specialOffer.departureCity];
    //[airportCodeLabel sizeToFit];
    
    UILabel *dateFlightLabel = [[UILabel alloc] initWithFrame:CGRectMake(flightlabel.frame.origin.x, airportCodeLabel.frame.origin.y + airportCodeLabel.frame.size.height, 0, 0)];
    dateFlightLabel.backgroundColor = [UIColor clearColor];
    dateFlightLabel.textColor = [UIColor COLOR_LABEL_TIME];
    dateFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:dateFlightLabel];
    dateFlightLabel.text = (isDest)?[self dateToHHmm:[dates objectAtIndex:0]]:[self dateToHHmm:[dates objectAtIndex:1]];
    [dateFlightLabel sizeToFit];
    
    UILabel *airportID = [[UILabel alloc] initWithFrame:CGRectMake(dateFlightLabel.frame.origin.x, dateFlightLabel.frame.origin.y + dateFlightLabel.frame.size.height, 0, 0)];
    airportID.backgroundColor = [UIColor clearColor];
    airportID.textColor = [UIColor COLOR_LABEL_TIME];
    airportID.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:airportID];
    airportID.text = (isDest)?[[flightIds objectAtIndex:0] stringValue]:[[flightIds objectAtIndex:1] stringValue];
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