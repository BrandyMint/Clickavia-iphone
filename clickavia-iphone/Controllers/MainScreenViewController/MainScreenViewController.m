//
//  MainScreenViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    _cm = [CitiesManager new];
    _cm.delay = 10;
    _departureDestination = [Destination new];
    _returnDestination = [Destination new];
    _departureCompleteView.isReturn = NO;
    _departureCompleteView.delegate = self;
    _returnCompleteView.delegate = self;
    _returnCompleteView.isReturn = YES;
    
    [_calendarView setDelegate:self];
    [_calendarView selectFlyToDaysByDateArray:[CACalendarMockDates generateFlyToDates]];
    [_calendarView selectFlyReturnDaysByDateArray:[CACalendarMockDates generateFlyReturnDates:[NSDate date]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Tab Bar delegate methods

- (NSString *)tabTitle
{
	return @"Календарь";
}

-(NSString*)tabImageName
{
    return nil;
}

#pragma mark CAFieldCompleteViewDelegate
- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView selectedDestination:(Destination*) destination
{
    if(fieldCompleteView==_departureCompleteView)
    {
        _departureDestination = destination;
        [_cm getDestinationsForReturn:@"" forDepartureDestination:_departureDestination completeBlock:^(NSArray *array)
         {
             [_returnCompleteView setAutocompleteData:array];
         }];
    }
    else
    {
        _returnDestination = destination;
    }
}

- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView textChanged:(NSString*) text
{
    if(fieldCompleteView == _departureCompleteView)
    {
        [_cm getDestinationsForDeparture:text completeBlock:^(NSArray *array)
         {
             [_departureCompleteView setAutocompleteData:array];
         }];
    }
    if(fieldCompleteView == _returnCompleteView)
    {
        [_cm getDestinationsForReturn:text forDepartureDestination:_departureDestination completeBlock:^(NSArray *array)
         {
             [_returnCompleteView setAutocompleteData:array];
         }];
    }
}
-(void)fieldCompleteViewNeedFront:(CAFieldCompleteView *)fieldCompleteView
{
    [self.view bringSubviewToFront:fieldCompleteView];
}
-(void)fieldCompleteViewBeginEditing:(CAFieldCompleteView *)fieldCompleteView
{
    if(fieldCompleteView == _departureCompleteView)
    {
        [_cm getDestinationsForDeparture:_departureCompleteView.text completeBlock:^(NSArray *array)
         {
             [_departureCompleteView setAutocompleteData:array];
         }];
    }
    if(fieldCompleteView == _returnCompleteView)
    {
        [_cm getDestinationsForReturn:_returnCompleteView.text forDepartureDestination:_departureDestination completeBlock:^(NSArray *array)
         {
             [_returnCompleteView setAutocompleteData:array];
         }];
    }
}

#pragma mark CACalendarViewDelegate

- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    if(_calendarView.flyToDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            NSLog(@"Была выбрана дата вылета");
        }
    }
    
    NSLog([date description]);
}
- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    NSLog([date description]);
}

@end
