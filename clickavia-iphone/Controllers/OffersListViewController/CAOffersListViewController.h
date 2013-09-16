//
//  CAOffersListViewController.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAOffersData.h"

#define ONEWAY_FLIGHT @"departure"
#define FLIGHT_BACK @"return"

@interface CAOffersListViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableOffers;

@end
