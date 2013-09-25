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
#import <CAManagers/CitiesManager.h>

@interface MainScreenViewController : UIViewController <CAFieldCompleteViewDelegate, CACalendarViewDelegate>

@property (strong,nonatomic) IBOutlet CAFieldCompleteView* departureCompleteView;
@property (strong,nonatomic) IBOutlet CAFieldCompleteView* returnCompleteView;
@property (strong,nonatomic) CitiesManager *cm;
@property (strong,nonatomic) Destination *departureDestination;
@property (strong,nonatomic) Destination *returnDestination;

@property (strong,nonatomic) IBOutlet CACalendarView* calendarView;

@end
