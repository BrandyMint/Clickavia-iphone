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
    Offer *_offer;
    
    UIView *blockView;
    
/*    UILabel *airlineTitleLabel;
    UILabel *airlineCodeLabel;
    UILabel *timeDepartureLabel;
    UILabel *cityDepartureLabel;
    UILabel *timeArrivalLabel;
    UILabel *cityArrivalLabel;
    UILabel *timeInFlightLabel;*/
}

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
    frame.origin.x += -5;
    frame.size.width -= 2 * -5;
    [super setFrame:frame];
}

-(void) initByOfferModel:(Offer*)offer
{
    _offer = offer;
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView.layer setCornerRadius:6];
    self.backgroundView.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    self.backgroundView.layer.shadowRadius = 1;
    self.backgroundView.layer.shadowOpacity = 0.7;
    [self.backgroundView setClipsToBounds:NO];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    

    blockView = [[UIView alloc] init];
    blockView.backgroundColor = [UIColor whiteColor];
    if(!_offer.isSpecial)   {
        [blockView.layer setCornerRadius:6];
        blockView.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
        blockView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
        blockView.layer.shadowRadius = 1;
        blockView.layer.shadowOpacity = 0.7;
        [blockView setClipsToBounds:NO];
    }
    else    {
        UILabel *specialTitle = [[UILabel alloc] initWithFrame:CGRectMake(6, 1, 0, 0)];
        specialTitle.backgroundColor = [UIColor clearColor];
        specialTitle.textColor = [UIColor whiteColor];
        specialTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
        specialTitle.text = @"СПЕЦПРЕДЛОЖЕНИЕ";
        [self.backgroundView addSubview:specialTitle];
        [specialTitle sizeToFit];
    }
    
    [self.backgroundView addSubview:blockView];
    
    [self createFlightBlock];
}

-(UIView*) createFlightBlock
{
    if(!_offer.isSpecial)
        blockView.frame = CGRectMake(0, 0, self.frame.size.width-18, CELL_HEIGHT_NORMAL+2);
    else    {
        blockView.frame = CGRectMake(0, (CELL_HEIGHT_SPECIAL-CELL_HEIGHT_NORMAL)/2, self.frame.size.width-18, CELL_HEIGHT_NORMAL+2);
    }
    
    UIView *topFlightView = [self createFlightSubblock:YES];
    [blockView addSubview:topFlightView];
    [self createLineByBottom: [self getBottom:topFlightView.frame]];
    
    UIView *middleFlightView = [self createFlightSubblock:NO];
    middleFlightView.frame = CGRectMake(0, [self getBottom:topFlightView.frame]+1, middleFlightView.frame.size.width, middleFlightView.frame.size.height);
    [blockView addSubview:middleFlightView];
    [self createLineByBottom: [self getBottom:middleFlightView.frame]];
    
    /*
    //if(airlineTitleLabel == nil)    {
        UILabel *airlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, 0, 0)];
        airlineTitleLabel.backgroundColor = [UIColor clearColor];
        airlineTitleLabel.textColor = [UIColor lightGrayColor];
        airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:airlineTitleLabel];
   // }
    airlineTitleLabel.text = @"Aeroflot";
    [airlineTitleLabel sizeToFit];
    
    //if(airlineCodeLabel == nil)    {
        UILabel *airlineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, [self getBottom:airlineTitleLabel.frame], 0, 0)];
        airlineCodeLabel.backgroundColor = [UIColor clearColor];
        airlineCodeLabel.textColor = [UIColor lightGrayColor];
        airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:airlineCodeLabel];
    //}
    airlineCodeLabel.text = @"SU 1568";
    [airlineCodeLabel sizeToFit];
    
    //if(timeDepartureLabel == nil)    {
        UILabel *timeDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 0, 0)];
        timeDepartureLabel.backgroundColor = [UIColor clearColor];
        timeDepartureLabel.textColor = [UIColor blackColor];
        timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:timeDepartureLabel];
    //}
    timeDepartureLabel.text = @"20:30";
    [timeDepartureLabel sizeToFit];
    
    //if(cityDepartureLabel == nil)    {
        UILabel *cityDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, [self getBottom:timeDepartureLabel.frame], 0, 0)];
        cityDepartureLabel.backgroundColor = [UIColor clearColor];
        cityDepartureLabel.textColor = [UIColor blackColor];
        cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:cityDepartureLabel];
    //}
    cityDepartureLabel.text = @"Москва";
    [cityDepartureLabel sizeToFit];
    
    //if(timeArrivalLabel == nil)    {
        UILabel *timeArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 6, 0, 0)];
        timeArrivalLabel.backgroundColor = [UIColor clearColor];
        timeArrivalLabel.textColor = [UIColor blackColor];
        timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:timeArrivalLabel];
    //}
    timeArrivalLabel.text = @"21:45";
    [timeArrivalLabel sizeToFit];
    
    //if(cityArrivalLabel == nil)    {
        UILabel *cityArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, [self getBottom:timeArrivalLabel.frame], 0, 0)];
        cityArrivalLabel.backgroundColor = [UIColor clearColor];
        cityArrivalLabel.textColor = [UIColor blackColor];
        cityArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:cityArrivalLabel];
    //}
    cityArrivalLabel.text = @"Краснодар";
    [cityArrivalLabel sizeToFit];
    
    //if(timeInFlightLabel == nil)    {
        UILabel *timeInFlightLabel = [[UILabel alloc] init];
        timeInFlightLabel.backgroundColor = [UIColor clearColor];
        timeInFlightLabel.textColor = [UIColor lightGrayColor];
        timeInFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [blockView addSubview:timeInFlightLabel];
    //}
    timeInFlightLabel.text = @"1:15";
    [timeInFlightLabel sizeToFit];
    timeInFlightLabel.frame = CGRectMake(self.frame.size.width-timeInFlightLabel.frame.size.width-18-5, 6, timeInFlightLabel.frame.size.width, timeInFlightLabel.frame.size.height);
     */
    
    return blockView;
}

-(UIView*) createFlightSubblock:(BOOL)isDest
{
    UIView *subBlockView = [[UIView alloc] init];
    
    //if(airlineTitleLabel == nil)    {
    UILabel *airlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, 0, 0)];
    airlineTitleLabel.backgroundColor = [UIColor clearColor];
    airlineTitleLabel.textColor = [UIColor lightGrayColor];
    airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:airlineTitleLabel];
    // }
    airlineTitleLabel.text = (isDest)?@"Aeroflot":@"Aeroflot";
    [airlineTitleLabel sizeToFit];
    
    //if(airlineCodeLabel == nil)    {
    UILabel *airlineCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, [self getBottom:airlineTitleLabel.frame], 0, 0)];
    airlineCodeLabel.backgroundColor = [UIColor clearColor];
    airlineCodeLabel.textColor = [UIColor lightGrayColor];
    airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [subBlockView addSubview:airlineCodeLabel];
    //}
    airlineCodeLabel.text = (isDest)?@"SU 1568":@"SU 1567";
    [airlineCodeLabel sizeToFit];
    
    //if(timeDepartureLabel == nil)    {
    UILabel *timeDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 0, 0)];
    timeDepartureLabel.backgroundColor = [UIColor clearColor];
    timeDepartureLabel.textColor = [UIColor blackColor];
    timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [subBlockView addSubview:timeDepartureLabel];
    //}
    timeDepartureLabel.text = (isDest)?@"20:30":@"22:30";
    [timeDepartureLabel sizeToFit];
    
    //if(cityDepartureLabel == nil)    {
    UILabel *cityDepartureLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, [self getBottom:timeDepartureLabel.frame], 0, 0)];
    cityDepartureLabel.backgroundColor = [UIColor clearColor];
    cityDepartureLabel.textColor = [UIColor blackColor];
    cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityDepartureLabel];
    //}
    cityDepartureLabel.text = (isDest)?@"Москва":@"Краснодар";
    [cityDepartureLabel sizeToFit];
    
    //if(timeArrivalLabel == nil)    {
    UILabel *timeArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 6, 0, 0)];
    timeArrivalLabel.backgroundColor = [UIColor clearColor];
    timeArrivalLabel.textColor = [UIColor blackColor];
    timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [subBlockView addSubview:timeArrivalLabel];
    //}
    timeArrivalLabel.text = (isDest)?@"21:45":@"23:40";
    [timeArrivalLabel sizeToFit];
    
    //if(cityArrivalLabel == nil)    {
    UILabel *cityArrivalLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, [self getBottom:timeArrivalLabel.frame], 0, 0)];
    cityArrivalLabel.backgroundColor = [UIColor clearColor];
    cityArrivalLabel.textColor = [UIColor blackColor];
    cityArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [subBlockView addSubview:cityArrivalLabel];
    //}
    cityArrivalLabel.text = (isDest)?@"Краснодар":@"Москва";
    [cityArrivalLabel sizeToFit];
    
    //if(timeInFlightLabel == nil)    {
    UILabel *timeInFlightLabel = [[UILabel alloc] init];
    timeInFlightLabel.backgroundColor = [UIColor clearColor];
    timeInFlightLabel.textColor = [UIColor lightGrayColor];
    timeInFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [subBlockView addSubview:timeInFlightLabel];
    //}
    timeInFlightLabel.text = (isDest)?@"1:15":@"1:15";
    [timeInFlightLabel sizeToFit];
    timeInFlightLabel.frame = CGRectMake(self.frame.size.width-timeInFlightLabel.frame.size.width-18-5, 6, timeInFlightLabel.frame.size.width, timeInFlightLabel.frame.size.height);
    
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

@end
