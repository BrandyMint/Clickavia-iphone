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

@interface MainScreenViewController : UIViewController

@property (strong,nonatomic) IBOutlet CACalendarView* calendarView;

@end
