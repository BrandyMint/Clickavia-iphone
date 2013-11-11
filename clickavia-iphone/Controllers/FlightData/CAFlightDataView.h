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
#import "SpecialOffer.h"

@interface CAFlightDataView : UIViewController <CASearchFormPickerViewDelegate, CAPaymentTableViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengerCount:(CAFlightPassengersCount*)passengerCount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil specialOffer:(SpecialOffer*)specialOffer;
@end
