//
//  CASpecialOffersViewController.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CASpecialOffers/CAScrollableTabViewDelegate.h>
#import <CAManagers/SpecialOffersManager.h>
#import "CASpecialOfferCell.h"

@class CAScrollableTabView;

@interface CASpecialOffersViewController : UIViewController <CAScrollableTabViewDelegate>

@property (nonatomic, weak) IBOutlet CAScrollableTabView *tabCities;
@property (nonatomic, weak) IBOutlet CAScrollableTabView *tabCountries;
@property (nonatomic, weak) IBOutlet UITableView *tableOffers;

@property (nonatomic, retain) IBOutlet CASpecialOfferCell *offerCell;

-(IBAction) onBack:(id)sender;

@end
