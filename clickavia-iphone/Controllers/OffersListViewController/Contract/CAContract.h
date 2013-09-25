//
//  CAContract.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/19/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAFlightDataView.h"
#import "Offer.h"
#import "FlightPassengersCount.h"

@interface CAContract : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengers:(FlightPassengersCount*)passengers;

@end
