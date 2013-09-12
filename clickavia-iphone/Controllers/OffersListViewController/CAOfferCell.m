//
//  CAOfferCell.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOfferCell.h"
#import <QuartzCore/QuartzCore.h>

#define CELL_MARGIN_TOP_BOTTOM  5
#define CELL_MARGIN_LEFT_RIGHT  3

@implementation CAOfferCell
{
    UIView *blockView;
}
@synthesize isMomentaryConfirmation, isSpecial;
@synthesize airlineCode, airlineTitle, timeArrival, timeDeparture, timeInFlight, cityArrival, cityDeparture;
@synthesize adultCount, kidCount, babuCount;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += -4;
    frame.size.width -= 2 * -4;
    [super setFrame:frame];
}

-(void) initByOfferModel:(Offer*)offer
{
    [self.layer setCornerRadius:6];
    self.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.7;
    [self setClipsToBounds:NO];
    self.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];

    blockView = [[UIView alloc] init];
    blockView.backgroundColor = [UIColor whiteColor];
    
    UILabel *specialTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 1, 0, 0)];
    specialTitle.backgroundColor = [UIColor clearColor];
    specialTitle.textColor = [UIColor whiteColor];
    specialTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    specialTitle.text = @"СПЕЦПРЕДЛОЖЕНИЕ";
    [specialTitle sizeToFit];
    [self addSubview:specialTitle];
/*
        [blockView.layer setCornerRadius:6];
        blockView.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
        blockView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
        blockView.layer.shadowRadius = 1;
        blockView.layer.shadowOpacity = 0.7;
        [blockView setClipsToBounds:NO];
*/
    
    [self createFlightBlock];
    
    [self addSubview:blockView];
}

-(UIView*) createFlightBlock
{
    if(isSpecial)
        blockView.frame = CGRectMake(9, (CELL_HEIGHT_SPECIAL-CELL_HEIGHT_NORMAL)/2, self.frame.size.width - 18, CELL_HEIGHT_NORMAL+2);
    else    {
        blockView.frame = CGRectMake(9, 0, self.frame.size.width-18, CELL_HEIGHT_NORMAL+2);
    }
   
    UIView *topFlightView = [self createFlightSubblock:YES];
    [blockView addSubview:topFlightView];
    [self createLineByBottom: [self getBottom:topFlightView.frame]+3];
    
    UIView *middleFlightView = [self createFlightSubblock:NO];
    middleFlightView.frame = CGRectMake(0, [self getBottom:topFlightView.frame]+1, middleFlightView.frame.size.width, middleFlightView.frame.size.height);
    [blockView addSubview:middleFlightView];
    [self createLineByBottom: [self getBottom:middleFlightView.frame]+3];
    
    return blockView;
}

-(UIView*) createFlightSubblock:(BOOL)isDest
{
    UIView *subBlockView = [[UIView alloc] init];
    //if(airlineTitleLabel == nil)    {
    UILabel *airlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 85, 14)];
    airlineTitleLabel.backgroundColor = [UIColor clearColor];
    airlineTitleLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:airlineTitleLabel];
    // }
    airlineTitleLabel.text = (isDest)?airlineTitle:airlineTitle;
    //[airlineTitleLabel sizeToFit];
    
    //if(airlineCodeLabel == nil)    {
    UILabel *airlineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, [self getBottom:airlineTitleLabel.frame], 80, 14)];
    airlineCodeLabel.backgroundColor = [UIColor clearColor];
    airlineCodeLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    [subBlockView addSubview:airlineCodeLabel];
    //}
    airlineCodeLabel.text = (isDest)?airlineCode:airlineCode;
    //[airlineCodeLabel sizeToFit];
    
    //if(timeDepartureLabel == nil)    {
    UILabel *timeDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 4, 0, 0)];
    timeDepartureLabel.backgroundColor = [UIColor clearColor];
    timeDepartureLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeDepartureLabel];
    //}
    timeDepartureLabel.text = (isDest)?[self dateToHHmm:timeDeparture]:[self dateToHHmm:timeArrival];
    [timeDepartureLabel sizeToFit];
    
    //if(cityDepartureLabel == nil)    {
    UILabel *cityDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, [self getBottom:timeDepartureLabel.frame], 100, 14)];
    cityDepartureLabel.backgroundColor = [UIColor clearColor];
    cityDepartureLabel.textColor = [UIColor blackColor];
    cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityDepartureLabel];
    //}
    cityDepartureLabel.text = (isDest)?cityDeparture:cityArrival;
    //[cityDepartureLabel sizeToFit];
    
    //if(timeArrivalLabel == nil)    {
    UILabel *timeArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 4, 0, 0)];
    timeArrivalLabel.backgroundColor = [UIColor clearColor];
    timeArrivalLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [subBlockView addSubview:timeArrivalLabel];
    //}
    timeArrivalLabel.text = (isDest)?[self dateToHHmm:timeArrival]:[self dateToHHmm:timeDeparture];
    [timeArrivalLabel sizeToFit];
    
    //if(cityArrivalLabel == nil)    {
    UILabel *cityArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, [self getBottom:timeArrivalLabel.frame], 100, 14)];
    cityArrivalLabel.backgroundColor = [UIColor clearColor];
    cityArrivalLabel.textColor = [UIColor blackColor];
    cityArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityArrivalLabel];
    //}
    cityArrivalLabel.text = (isDest)?cityArrival:cityDeparture;
    //[cityArrivalLabel sizeToFit];
    
    //if(timeInFlightLabel == nil)    {
    UILabel *timeInFlightLabel = [[UILabel alloc] init];
    timeInFlightLabel.backgroundColor = [UIColor clearColor];
    timeInFlightLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    timeInFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:timeInFlightLabel];
    //}
    timeInFlightLabel.text = (isDest)?[self dateToHHmm:timeInFlight]:[self dateToHHmm:timeInFlight];
    [timeInFlightLabel sizeToFit];
    timeInFlightLabel.frame = CGRectMake(self.frame.size.width-timeInFlightLabel.frame.size.width-23, 6, timeInFlightLabel.frame.size.width, timeInFlightLabel.frame.size.height);
    
    UIImageView* clock = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-timeInFlightLabel.frame.size.width-45, 6, 15, 15)];
    clock.image = [UIImage imageNamed:@"clock-icon@2x.png"];
    [subBlockView addSubview:clock];
    
    if (isDest) {        
        UIImageView* man = [[UIImageView alloc] initWithFrame:CGRectMake(4, 103, 10, 26)];
        man.image = [UIImage imageNamed:@"passengers-icon-man@2x.png"];
        [subBlockView addSubview:man];
        
        UILabel* adultsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(man.frame.origin.x + man.frame.size.width + 4, 108, 0, 0)];
        adultsCountLabel.backgroundColor = [UIColor clearColor];
        adultsCountLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        adultsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        adultsCountLabel.text = [NSString stringWithFormat:@"%d",adultCount];;
        [subBlockView addSubview:adultsCountLabel];
        [adultsCountLabel sizeToFit];
        
        UIImageView* kid = [[UIImageView alloc] initWithFrame:CGRectMake(adultsCountLabel.frame.origin.x + adultsCountLabel.frame.size.width + 9, 105, 11, 23)];
        kid.image = [UIImage imageNamed:@"passengers-icon-kid@2x.png"];
        [subBlockView addSubview:kid];
        
        UILabel* kidsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kid.frame.origin.x + kid.frame.size.width + 4, 108, 0, 0)];
        kidsCountLabel.backgroundColor = [UIColor clearColor];
        kidsCountLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        kidsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        kidsCountLabel.text = [NSString stringWithFormat:@"%d",kidCount];
        [subBlockView addSubview:kidsCountLabel];
        [kidsCountLabel sizeToFit];
        
        UIImageView* baby = [[UIImageView alloc] initWithFrame:CGRectMake(kidsCountLabel.frame.origin.x + kidsCountLabel.frame.size.width + 9, 108, 12, 18)];
        baby.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
        [subBlockView addSubview:baby];
        
        UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(baby.frame.origin.x + baby.frame.size.width + 4, 108, 0, 0)];
        babyiesCountLabel.backgroundColor = [UIColor clearColor];
        babyiesCountLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        babyiesCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        babyiesCountLabel.text = [NSString stringWithFormat:@"%d",babuCount];
        [subBlockView addSubview:babyiesCountLabel];
        [babyiesCountLabel sizeToFit];
        
        if (isMomentaryConfirmation) {
            UIImageView* check = [[UIImageView alloc] initWithFrame:CGRectMake(132, 138, 10, 10)];
            check.image = [UIImage imageNamed:@"check-icon-green@2x.png"];
            [subBlockView addSubview:check];
            
            UILabel *instant = [[UILabel alloc] initWithFrame:CGRectMake(145, 135, 0, 0)];
            instant.backgroundColor = [UIColor clearColor];
            instant.textColor = [UIColor colorWithRed:100.0f/255.0f green:148.0f/255.0f blue:28.0f/255.0f alpha:1];
            instant.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
            [subBlockView addSubview:instant];
            instant.text = @"мгновенное подтверждение";
            [instant sizeToFit];
        }
        
    }

    subBlockView.frame = CGRectMake(0, 0, self.frame.size.width-18, [self getBottom:cityArrivalLabel.frame]);
    
    return subBlockView;
}

-(void) createLineByBottom:(NSInteger)yBottom
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yBottom, self.frame.size.width-18, 1)];
    line.backgroundColor = [UIColor grayColor];
    [blockView addSubview:line];
}

-(NSInteger) getBottom:(CGRect)rect
{
    return rect.origin.y+rect.size.height;
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
