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
#import "SpecialOffer.h"
#import "CAPopoverList.h"
#import "WYPopoverController.h"

@interface CAFlightDataView : UIViewController <CASearchFormPickerViewDelegate, WYPopoverControllerDelegate, CAPopoverListDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengerCount:(CAFlightPassengersCount*)passengerCount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil specialOffer:(SpecialOffer*)specialOffer;
@end
