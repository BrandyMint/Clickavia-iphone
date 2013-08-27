//
//  CASpecOffersViewController.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAScrollableTabViewDelegate.h"

#import "SpecialOffersManager.h"
#import "SpecialOfferCell.h"

@class CAScrollableTabView;

@interface CASpecOffersViewController : UIViewController <CAScrollableTabViewDelegate>

@property (weak, nonatomic) IBOutlet CAScrollableTabView *tabTitle;
@property (nonatomic, weak) IBOutlet CAScrollableTabView *tabCities;
@property (nonatomic, weak) IBOutlet CAScrollableTabView *tabCountries;
@property (nonatomic, weak) IBOutlet UITableView *tableOffers;

@property (nonatomic, retain) IBOutlet SpecialOfferCell *offerCell;

-(IBAction) onRefresh:(id)sender;

@end
