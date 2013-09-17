//
//  MainScreenViewController.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CACalendarView/CACalendarView.h>
#import "CAFieldCompleteView.h"
#import <CAManagers/CitiesManager.h>
#import <CAManagers/FlightsManager.h>

@interface SearchFlightViewController : UIViewController <CAFieldCompleteViewDelegate,CACalendarViewDelegate>
{
    FlightsManager *fm;
    CitiesManager *cm;
    SearchConditions *currentSearchConditions;
    NSArray *departureDates;
    NSArray *returnDates;
    NSDate *departureDate;
    NSDate *returnDate;
}

@property (strong,nonatomic) IBOutlet CAFieldCompleteView* departureCompleteView;
@property (strong,nonatomic) IBOutlet CAFieldCompleteView* returnCompleteView;
//@property (strong,nonatomic) Destination *departureDestination;
//@property (strong,nonatomic) Destination *returnDestination;
@property (strong,nonatomic) IBOutlet CACalendarView* calendarView;

@property (strong,nonatomic) IBOutlet UISwitch *switchBoth;
@property (strong,nonatomic) IBOutlet UIButton *countButton;
@property (strong,nonatomic) IBOutlet UIButton *flightClassButton;
@property (strong,nonatomic) IBOutlet UILabel *switchDescription;
- (SearchConditions*) getSearchConditions;
- (IBAction)changeFlightType:(id)sender;
- (IBAction)changeIsBothWays:(id)sender;
@end
