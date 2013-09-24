//
//  CAFligthDataView.h
//  clickavia-iphone
//
//  Created by bespalown on 9/23/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "FlightPassengersCount.h"

@interface CAFligthDataView : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengers:(FlightPassengersCount*)passengers;

@end
