//
//  CAOrderRequirements.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 20/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchConditions.h"
#import "Offer.h"
#import "OfferConditions.h"

@interface CAOrderRequirements : UIView

- (UIView* )initWithRequirements:(flightType)flightType dateDeparture:(NSString*)dateDeparture dateArrival:(NSString*)dateArrival code:(NSString*)code;

@end
