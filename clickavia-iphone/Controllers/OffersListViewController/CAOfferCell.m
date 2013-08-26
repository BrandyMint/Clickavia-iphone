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
    
    UILabel *airlineTitleLabel;
    UILabel *airlineCodeLabel;
    UILabel *timeDepartureLabel;
    UILabel *cityDepartureLabel;
    UILabel *timeArrivalLabel;
    UILabel *cityArrivalLabel;
    UILabel *timeInFlightLabel;
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
    
    if(airlineTitleLabel == nil)    {
        airlineTitleLabel = [[UILabel alloc] init];
        airlineTitleLabel.backgroundColor = [UIColor clearColor];
        airlineTitleLabel.textColor = [UIColor lightGrayColor];
        airlineTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:airlineTitleLabel];
    }
    airlineTitleLabel.text = @"Aeroflot";
    
    if(airlineCodeLabel == nil)    {
        airlineCodeLabel = [[UILabel alloc] init];
        airlineCodeLabel.backgroundColor = [UIColor clearColor];
        airlineCodeLabel.textColor = [UIColor lightGrayColor];
        airlineCodeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:airlineCodeLabel];
    }
    airlineCodeLabel.text = @"SU 1568";
    
    if(timeDepartureLabel == nil)    {
        timeDepartureLabel = [[UILabel alloc] init];
        timeDepartureLabel.backgroundColor = [UIColor clearColor];
        timeDepartureLabel.textColor = [UIColor blackColor];
        timeDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:timeDepartureLabel];
    }
    timeDepartureLabel.text = @"20:30";
    
    if(cityDepartureLabel == nil)    {
        cityDepartureLabel = [[UILabel alloc] init];
        cityDepartureLabel.backgroundColor = [UIColor clearColor];
        cityDepartureLabel.textColor = [UIColor blackColor];
        cityDepartureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:cityDepartureLabel];
    }
    cityDepartureLabel.text = @"Москва";
    
    if(timeArrivalLabel == nil)    {
        timeArrivalLabel = [[UILabel alloc] init];
        timeArrivalLabel.backgroundColor = [UIColor clearColor];
        timeArrivalLabel.textColor = [UIColor blackColor];
        timeArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [blockView addSubview:timeArrivalLabel];
    }
    timeArrivalLabel.text = @"21:45";
    
    if(cityArrivalLabel == nil)    {
        cityArrivalLabel = [[UILabel alloc] init];
        cityArrivalLabel.backgroundColor = [UIColor clearColor];
        cityArrivalLabel.textColor = [UIColor blackColor];
        cityArrivalLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [blockView addSubview:cityArrivalLabel];
    }
    cityArrivalLabel.text = @"Краснодар";
    
    if(timeInFlightLabel == nil)    {
        timeInFlightLabel = [[UILabel alloc] init];
        timeInFlightLabel.backgroundColor = [UIColor clearColor];
        timeInFlightLabel.textColor = [UIColor lightGrayColor];
        timeInFlightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [blockView addSubview:timeInFlightLabel];
    }
    timeInFlightLabel.text = @"1:15";
    
    return blockView;
}

@end
