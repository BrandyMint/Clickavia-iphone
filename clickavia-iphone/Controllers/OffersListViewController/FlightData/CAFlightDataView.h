//
//  CAFlightDataView.h
//  clickavia-iphone
//
//  Created by bespalown on 9/23/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "CAFlightPassengersCount.h"

#import "CASearchFormPickerView.h"
#import "CATooltipSelect.h"


@interface CAFlightDataView : UIViewController <CASearchFormPickerViewDelegate, CAPaymentTableViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengers:(CAFlightPassengersCount*)passengers;

@end
