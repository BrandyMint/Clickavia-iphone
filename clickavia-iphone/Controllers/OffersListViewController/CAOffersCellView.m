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
    UILabel *momentaryConfirmationLabel;
}

@synthesize caOffersListViewController;

- (UIView*) initByOfferModel:(Offer*)offers passangers:(FlightPassengersCount*)passangers;
{
    flightDepartureObject = [[Flight alloc] init];
    flightReturnObject = [[Flight alloc] init];
    flightDepartureObject = offers.flightDeparture;
    flightReturnObject = offers.flightReturn;
    
    int heightViewFrame = 0;
    if (offers.isSpecial)
        heightViewFrame = CELL_HEIGHT_SPECIAL;
    else
        heightViewFrame = CELL_HEIGHT_NORMAL;
    
    UIView* cardView = [[UIView alloc] initWithFrame:CGRectMake(CELL_MARGIN_LEFT, 0, [[UIScreen mainScreen] bounds].size.width-2*CELL_MARGIN_LEFT, heightViewFrame)];
    [cardView.layer setCornerRadius:6];
    cardView.layer.shadowColor = [[UIColor COLOR_BACKGROUND_CARD_VIEW_SHADOW] CGColor];
    cardView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    cardView.layer.shadowRadius = 1;
    cardView.layer.shadowOpacity = 0.7;
    [cardView setClipsToBounds:NO];
    cardView.backgroundColor = [UIColor COLOR_BACKGROUND_CARD_VIEW];
    
    CGRect contenViewFrame = CGRectZero;
    
    if (offers.isSpecial) {
        UILabel *specialTitle = [[UILabel alloc] initWithFrame:CGRectMake(6, 1, 0, 0)];
        specialTitle.backgroundColor = [UIColor clearColor];
        specialTitle.textColor = [UIColor whiteColor];
        specialTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
        specialTitle.text = @"СПЕЦПРЕДЛОЖЕНИЕ";
        [specialTitle sizeToFit];
        [cardView addSubview:specialTitle];
        
        contenViewFrame = CGRectMake(0, CELL_SPECIAL_PADDING, cardView.frame.size.width, CELL_HEIGHT_NORMAL);
    }
    else
    {
        
        contenViewFrame = CGRectMake(0, cardView.frame.origin.y, cardView.frame.size.width, CELL_HEIGHT_NORMAL);
    }
    contenView = [[UIView alloc] initWithFrame:contenViewFrame];
    contenView.backgroundColor = [UIColor whiteColor];
    if (!offers.isSpecial) {
        [contenView.layer setCornerRadius:6];
    }
    
    if (offers.isMomentaryConfirmation) {
        UIImageView* check = [[UIImageView alloc] initWithFrame:CGRectMake(130, CELL_HEIGHT_NORMAL - 14, 10, 10)];
        check.image = [UIImage imageNamed:@"check-icon-green@2x.png"];
        [contenView addSubview:check];
        
        momentaryConfirmationLabel = [[UILabel alloc] initWithFrame:CGRectMake(check.frame.origin.x + check.frame.size.width + 5, CELL_HEIGHT_NORMAL - 17, 0, 0)];
        momentaryConfirmationLabel.backgroundColor = [UIColor clearColor];
        momentaryConfirmationLabel.textColor = [UIColor COLOR_TEXT_MOMENTARYCONFIRMATION];
        momentaryConfirmationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
        [contenView addSubview:momentaryConfirmationLabel];
        momentaryConfirmationLabel.text = @"мгновенное подтверждение";
        [momentaryConfirmationLabel sizeToFit];
    }
    
    UIView *departFlightView = [self createFlightSubblock:YES];
    departFlightView.frame = CGRectMake(contenView.frame.origin.x, 0, contenView.frame.size.width, 50);
    [self createLineByBottom: [self getBottom:departFlightView.frame]];
    
    UIView *returnFlightView = [self createFlightSubblock:NO];
    returnFlightView.frame = CGRectMake(contenView.frame.origin.x, [self getBottom:departFlightView.frame], contenView.frame.size.width, departFlightView.frame.size.height);
    [self createLineByBottom: [self getBottom:returnFlightView.frame]];
    
    [contenView addSubview:departFlightView];
    [contenView addSubview:returnFlightView];
    
    UIImageView* adultsImage = [[UIImageView alloc] initWithFrame:CGRectMake(contenView.frame.origin.x + 10, [self getBottom:returnFlightView.frame]+10, 10, 26)];
    adultsImage.image = [UIImage imageNamed:@"passengers-icon-man@2x.png"];
    UILabel* adultsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(adultsImage.frame.origin.x + adultsImage.frame.size.width + 4, [self getBottom:returnFlightView.frame]+14, 0, 0)];
    adultsCountLabel.backgroundColor = [UIColor clearColor];
    adultsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    adultsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    adultsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.adults];
    [adultsCountLabel sizeToFit];
    
    [contenView addSubview:adultsImage];
    [contenView addSubview:adultsCountLabel];
    
    UIImageView* kidsImage = [[UIImageView alloc] initWithFrame:CGRectMake(adultsCountLabel.frame.origin.x + adultsCountLabel.frame.size.width + 9, [self getBottom:returnFlightView.frame]+13, 8, 20)];
    kidsImage.image = [UIImage imageNamed:@"passengers-icon-kid@2x.png"];
    UILabel* kidsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kidsImage.frame.origin.x + kidsImage.frame.size.width + 4, [self getBottom:returnFlightView.frame]+14, 0, 0)];
    kidsCountLabel.backgroundColor = [UIColor clearColor];
    kidsCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    kidsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    kidsCountLabel.text = [NSString stringWithFormat:@"%d",passangers.kids];
    [kidsCountLabel sizeToFit];
    
    [contenView addSubview:kidsImage];
    [contenView addSubview:kidsCountLabel];
    
    UIImageView* babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(kidsCountLabel.frame.origin.x + kidsCountLabel.frame.size.width + 9, [self getBottom:returnFlightView.frame]+14, 11, 18)];
    babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(babyImage.frame.origin.x + babyImage.frame.size.width + 4, [self getBottom:returnFlightView.frame]+14, 0, 0)];
    babyiesCountLabel.backgroundColor = [UIColor clearColor];
    babyiesCountLabel.textColor = [UIColor COLOR_PASSANGER_COUNT];
    babyiesCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    babyiesCountLabel.text = [NSString stringWithFormat:@"%d",passangers.babies];
    [babyiesCountLabel sizeToFit];
    
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
    airlineCodeLabel.text = (isDest)?flightDepartureObject.ID:flightReturnObject.ID;
    
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
