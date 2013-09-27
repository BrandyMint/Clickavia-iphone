//
//  MainScreenViewController.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CACalendarView/CACalendarView.h>
#import "CACalendarMockDates.h"
#import "CAFieldCompleteView.h"
#import "CASearchFormView.h"
#import <CAManagers/CitiesManager.h>

#import <UIKit/UIKit.h>
#import <CACalendarView/CACalendarView.h>
#import "CAFieldCompleteView.h"
#import <CAManagers/CitiesManager.h>
#import <CAManagers/FlightsManager.h>
#import <CAManagers/OfferConditions.h>
#import "CAAppDelegate.h"

@interface MainScreenViewController : UIViewController <CACalendarViewDelegate, CASearchFormViewDelegate>
{
    FlightsManager *fm;
    CitiesManager *cm;
    SearchConditions *currentSearchConditions;
    CACalendarView* calendarView;
    NSArray *departureDates;
    NSArray *returnDates;
    NSDate *departureDate;
    NSDate *returnDate;
}
@property (strong,nonatomic) IBOutlet CAFieldCompleteView* departureCompleteView;
@property (strong,nonatomic) IBOutlet CAFieldCompleteView* returnCompleteView;
@property (strong,nonatomic) CACalendarView* calendarView;

@property (strong, nonatomic) IBOutlet CASearchFormView *searchForm;

@property (strong,nonatomic) IBOutlet UISwitch *switchBoth;
@property (strong,nonatomic) IBOutlet UIButton *countButton;
@property (strong,nonatomic) IBOutlet UIButton *flightClassButton;
@property (strong,nonatomic) IBOutlet UILabel *switchDescription;
- (SearchConditions*) getSearchConditions;
- (OfferConditions*) getOfferConditions;

@property (weak, nonatomic) IBOutlet UIButton *find_ou;
- (IBAction)find:(id)sender;
@end
