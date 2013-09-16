//
//  OfferCellDetails.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/16/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersCellView.h"

@interface OfferCellDetails : CAOffersCellView

- (UIView*) initByOfferModel:(Offer*)offers passangers:(FlightPassengersCount*)passangers;

@end
