//
//  CAFlightsViewController.h
//  clickavia-iphone
//
//  Created by macmini1 on 02.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAFieldCompleteView.h"
#import "CACalendarView.h"

@interface CAFlightsViewController : UIViewController
{

}
@property (strong,nonatomic) IBOutlet CAFieldCompleteView *departureFieldView;
@property (strong,nonatomic) IBOutlet CAFieldCompleteView *returnFieldView;
@property (strong,nonatomic) IBOutlet CACalendarView *calendarView;
@end
