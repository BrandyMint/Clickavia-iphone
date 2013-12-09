//
//  CAPersonalLaterViewController.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 22/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "CAFlightPassengersCount.h"

@interface CAPersonalLaterViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil
              bundle:(NSBundle *)nibBundleOrNil
              status:(NSString*)status
             manager:(NSString*)manager
                userName:(NSString*)userName
         numberOrder:(NSInteger)numberOrder
               offer:(Offer*)offer
           passenger:(CAFlightPassengersCount*)passenger
           isCurrentOrders:(BOOL)isCurrentOrders;

@end
