//
//  CACell.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/13/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersCellView.h"
#import "CAOffersCell.h"


#define LABEL_AIRPORT_WIDTH 80
#define LABEL_COLUMN_DEPARTURE 100

@implementation CAOffersCellView
{
    UIView* contenView;
    
    Flight* flightDepartureObject;
    Flight* flightReturnObject;
}

- (NSInteger)heightViewFrame:(Offer*)offerObject
{
    if (offerObject.isSpecial)
        return CELL_HEIGHT_SPECIAL;
    else
        return CELL_HEIGHT_NORMAL;
}

-(void)setupCardViewAppearence:(UIView*)cardView
{
    [cardView.layer setCornerRadius:6];
    cardView.layer.shadowColor = [[UIColor COLOR_BACKGROUND_CARD_VIEW_SHADOW] CGColor];
    cardView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    cardView.layer.shadowRadius = 1;
    cardView.layer.shadowOpacity = 0.7;
    [cardView setClipsToBounds:NO];
    cardView.backgroundColor = [UIColor COLOR_BACKGROUND_CARD_VIEW];
}
-(void)setupSpecialTitleAppearence:(UILabel*)specialTitle
{
    specialTitle.backgroundColor = [UIColor clearColor];
    specialTitle.textColor = [UIColor whiteColor];
    specialTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    specialTitle.text = @"СПЕЦПРЕДЛОЖЕНИЕ";
    [specialTitle sizeToFit];
}
-(void)setupMomentaryConfirmationAppearence:(UILabel*)momentaryConfirmationLabel
{
    momentaryConfirmationLabel.backgroundColor = [UIColor clearColor];
    momentaryConfirmationLabel.textColor = [UIColor COLOR_TEXT_MOMENTARYCONFIRMATION];
    momentaryConfirmationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    momentaryConfirmationLabel.text = @"мгновенное подтверждение";
    [momentaryConfirmationLabel sizeToFit];
}
-(void)setupPassengerCountLabelAppearence:(UILabel*)passengerCountLabel
{
    passengerCountLabel.backgroundColor = [UIColor clearColor];
    passengerCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    passengerCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [passengerCountLabel sizeToFit];
}
- (void)addMomentaryConfirmation:(UIView*)view
{
    UIImageView* check = [[UIImageView alloc] initWithFrame:CGRectMake(130, CELL_HEIGHT_NORMAL - 14, 10, 10)];
    check.image = [UIImage imageNamed:@"check-icon-green@2x.png"];
    [view addSubview:check];
    UILabel *momentaryConfirmationLabel = [[UILabel alloc] initWithFrame:CGRectMake(check.frame.origin.x + check.frame.size.width + 5, CELL_HEIGHT_NORMAL - 17, 0, 0)];
    [self setupMomentaryConfirmationAppearence:momentaryConfirmationLabel];
    [view addSubview:momentaryConfirmationLabel];
}
- (UIView*) initByOfferModel:(Offer*)offerObject passengers:(FlightPassengersCount*)offerPassengers;
{
    flightDepartureObject = offerObject.flightDeparture;
    flightReturnObject = offerObject.flightReturn;
    
    int heightViewFrame = [self heightViewFrame:offerObject];
    
    UIView* cardView = [[UIView alloc] initWithFrame:CGRectMake(CELL_MARGIN_LEFT, 0, [[UIScreen mainScreen] bounds].size.width-2*CELL_MARGIN_LEFT, heightViewFrame)];
    [self setupCardViewAppearence:cardView];
    
    CGRect contenViewFrame = CGRectZero;
    
    if (offerObject.isSpecial) {
        UILabel *specialTitle = [[UILabel alloc] initWithFrame:CGRectMake(6, 1, 0, 0)];
        [self setupSpecialTitleAppearence:specialTitle];
        [cardView addSubview:specialTitle];
        contenViewFrame = CGRectMake(0, CELL_SPECIAL_PADDING, cardView.frame.size.width, CELL_HEIGHT_NORMAL);
    }
    else
    {
        contenViewFrame = CGRectMake(0, cardView.frame.origin.y, cardView.frame.size.width, CELL_HEIGHT_NORMAL);
    }
    contenView = [[UIView alloc] initWithFrame:contenViewFrame];
    contenView.backgroundColor = [UIColor whiteColor];
    if (!offerObject.isSpecial) {
        [contenView.layer setCornerRadius:6];
    }
    
    if (offerObject.isMomentaryConfirmation) {
        [self addMomentaryConfirmation:contenView];

    }
    
    UIView *departFlightView = [self createFlightSubblock:YES];
    departFlightView.frame = CGRectMake(contenView.frame.origin.x, 0, contenView.frame.size.width, 50);
    [self createLineByBottom: [self getBottom:departFlightView.frame]];

    [contenView addSubview:departFlightView];
    NSInteger bottomBorderForFlightsView =[self getBottom:departFlightView.frame];;
    
    if(flightReturnObject!=nil)
    {
        UIView *returnFlightView = [self createFlightSubblock:NO];
        returnFlightView.frame = CGRectMake(contenView.frame.origin.x, [self getBottom:departFlightView.frame], contenView.frame.size.width, departFlightView.frame.size.height);
        [self createLineByBottom: [self getBottom:returnFlightView.frame]];
        [contenView addSubview:returnFlightView];
        bottomBorderForFlightsView = [self getBottom:returnFlightView.frame];
    }
   
    
    UIImageView* adultsImage = [[UIImageView alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 10, bottomBorderForFlightsView+10, 10, 26)];
    adultsImage.image = [UIImage imageNamed:@"passengers-icon-man@2x.png"];
    UILabel* adultsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(adultsImage.frame.origin.x + adultsImage.frame.size.width + 4, bottomBorderForFlightsView+14, 0, 0)];
    adultsCountLabel.text = [NSString stringWithFormat:@"%d",offerPassengers.adults];
    [self setupPassengerCountLabelAppearence:adultsCountLabel];
    [contenView addSubview:adultsImage];
    [contenView addSubview:adultsCountLabel];
    
    UIImageView* kidsImage = [[UIImageView alloc] initWithFrame:CGRectMake(adultsCountLabel.frame.origin.x + adultsCountLabel.frame.size.width + 9, bottomBorderForFlightsView+13, 8, 20)];
    kidsImage.image = [UIImage imageNamed:@"passengers-icon-kid@2x.png"];
    UILabel* kidsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kidsImage.frame.origin.x + kidsImage.frame.size.width + 4, bottomBorderForFlightsView+14, 0, 0)];
    kidsCountLabel.text = [NSString stringWithFormat:@"%d",offerPassengers.kids];
    [self setupPassengerCountLabelAppearence:kidsCountLabel];
    [contenView addSubview:kidsImage];
    [contenView addSubview:kidsCountLabel];
    
    UIImageView* babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(kidsCountLabel.frame.origin.x + kidsCountLabel.frame.size.width + 9, bottomBorderForFlightsView+14, 11, 18)];
    babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(babyImage.frame.origin.x + babyImage.frame.size.width + 4, bottomBorderForFlightsView+14, 0, 0)];
    babyiesCountLabel.text = [NSString stringWithFormat:@"%d",offerPassengers.babies];
    [self setupPassengerCountLabelAppearence:babyiesCountLabel];
    [contenView addSubview:babyImage];
    [contenView addSubview:babyiesCountLabel];
    
    [cardView addSubview:contenView];
    return cardView;
}

-(UIView*) createFlightSubblock:(BOOL)isDest
{
    UIView *subBlockView = [[UIView alloc] init];
    
    UILabel *airlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 12, 9, LABEL_AIRPORT_WIDTH, 14)];
    airlineTitleLabel.backgroundColor = [UIColor clearColor];
    airlineTitleLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airlineTitleLabel];
    airlineTitleLabel.text = (isDest)?flightDepartureObject.airportArrival:flightReturnObject.airportDeparture;
    
    UILabel *airlineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 9, [self getBottom:airlineTitleLabel.frame]+5, LABEL_AIRPORT_WIDTH, 14)];
    airlineCodeLabel.backgroundColor = [UIColor clearColor];
    airlineCodeLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    [subBlockView addSubview:airlineCodeLabel];
    airlineCodeLabel.text = (isDest)? flightDepartureObject.code:flightReturnObject.code;
    
    UILabel *timeDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + LABEL_AIRPORT_WIDTH + 10, 7, 0, 0)];
    timeDepartureLabel.backgroundColor = [UIColor clearColor];
    timeDepartureLabel.textColor = [UIColor COLOR_LABEL_TIME];
    timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeDepartureLabel];
    timeDepartureLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.dateAndTimeDeparture]:[self dateToHHmm:flightReturnObject.dateAndTimeDeparture];
    [timeDepartureLabel sizeToFit];
    
    UILabel *cityDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeDepartureLabel.frame.origin.x, [self getBottom:timeDepartureLabel.frame], LABEL_COLUMN_DEPARTURE, 14)];
    cityDepartureLabel.backgroundColor = [UIColor clearColor];
    cityDepartureLabel.textColor = [UIColor blackColor];
    cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityDepartureLabel];
    cityDepartureLabel.text = (isDest)?flightDepartureObject.cityDeparture:flightReturnObject.cityDeparture;
    
    UILabel *timeArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeDepartureLabel.frame.origin.x + LABEL_COLUMN_DEPARTURE, 7, 0, 0)];
    timeArrivalLabel.backgroundColor = [UIColor clearColor];
    timeArrivalLabel.textColor = [UIColor COLOR_LABEL_TIME];
    timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeArrivalLabel];
    timeArrivalLabel.text = (isDest)?[self dateToHHmm:flightDepartureObject.dateAndTimeArrival]:[self dateToHHmm:flightReturnObject.dateAndTimeArrival];
    [timeArrivalLabel sizeToFit];
    
    UILabel *cityArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(cityDepartureLabel.frame.origin.x + LABEL_COLUMN_DEPARTURE, [self getBottom:timeArrivalLabel.frame], LABEL_COLUMN_DEPARTURE, 14)];
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
