//
//  CAOffersListViewController.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferConditions.h"

#define ONEWAY_FLIGHT @"departure"
#define FLIGHT_BACK @"return"

@interface CAOffersListViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableOffers;
@property (nonatomic,weak) OfferConditions *offerConditions;
@property (nonatomic,strong) IBOutlet UIView *loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isBothWays:(BOOL) isBothWays;

-(NSString*)priceBehavior:(NSDecimalNumber*)priceBehavior;

@end
