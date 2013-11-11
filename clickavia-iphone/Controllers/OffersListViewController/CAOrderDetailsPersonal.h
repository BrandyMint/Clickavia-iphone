//
//  FlightDetails.h
//  clickavia-iphone
//
//  Created by bespalown on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersCellView.h"
#import <QuartzCore/QuartzCore.h>
#import "SpecialOffer.h"
#import "CAFlightPassengersCount.h"

#define COLOR_BACKGROUND_CARD_VIEW colorWithRed:236.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f
#define COLOR_BACKGROUND_CARD_VIEW_SHADOW colorWithRed:71.0f/255.0f green:71.0f/255.0f blue:71.0f/255.0f alpha:1.0f
#define COLOR_TEXT_MOMENTARYCONFIRMATION colorWithRed:100.0f/255.0f green:148.0f/255.0f blue:28.0f/255.0f alpha:1.0f
#define COLOR_PASSANGER_COUNT colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f
#define COLOR_LABEL_TIME colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f

@interface CAOrderDetailsPersonal : UIView

@property (nonatomic, retain) SpecialOffer* specialOffer;
@property (nonatomic, retain) CAFlightPassengersCount* offerPassengers;

- (UIView*) initByOfferModel:(SpecialOffer*)specialOfferData passengers:(CAFlightPassengersCount*)offerPassengersData;

@end
