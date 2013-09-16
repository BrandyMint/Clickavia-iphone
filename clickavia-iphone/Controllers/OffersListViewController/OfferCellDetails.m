//
//  OfferCellDetails.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "OfferCellDetails.h"

@implementation OfferCellDetails
{

}

- (UIView*) initByOfferModel:(Offer*)offers passangers:(FlightPassengersCount*)passangers
{
    flightDepartureObject = [[Flight alloc] init];
    flightReturnObject = [[Flight alloc] init];
    flightDepartureObject = offers.flightDeparture;
    flightReturnObject = offers.flightReturn;
    
    UIView* cardVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    /*
    UIImageView* babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 14, 11, 18)];
    babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    UILabel* babyiesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 14, 0, 0)];
    babyiesCountLabel.backgroundColor = [UIColor clearColor];
    babyiesCountLabel.textColor = [UIColor orangeColor];
    babyiesCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    babyiesCountLabel.text = [NSString stringWithFormat:@"%d",passangers.babies];
    [babyiesCountLabel sizeToFit];
    
    [cardVie addSubview:babyImage];
    [cardVie addSubview:babyiesCountLabel];
    */
    
    //babyImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 14, 11, 18)];
    //babyImage.image = [UIImage imageNamed:@"passengers-icon-baby@2x.png"];
    //[cardVie addSubview:babyImage];
    
    return cardVie;
}


@end
