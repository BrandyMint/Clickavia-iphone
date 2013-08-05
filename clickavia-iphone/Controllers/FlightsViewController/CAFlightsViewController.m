//
//  CAFlightsViewController.m
//  clickavia-iphone
//
//  Created by macmini1 on 02.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAFlightsViewController.h"

@interface CAFlightsViewController ()

@end

@implementation CAFlightsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        citiesManager = [CitiesManager new];
        citiesManager.delay = 50;
        flightsManager = [FlightsManager new];
        departureDates = [NSArray new];
        returnDates = [NSArray new];
        currentSearchConditions = [[SearchConditions alloc] init];
        currentSearchConditions.isBothWays = NO;
        currentSearchConditions.countOfTickets = [[NSNumber alloc] initWithInt:1];
        currentSearchConditions.typeOfFlight = econom;
        currentSearchConditions.direction_departure = nil;
        currentSearchConditions.direction_return = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [self setupTextForFlightTypeButton];
    [self setupSwitchBoth];
    [_departureFieldView setDelegate:self];
    [_returnFieldView setDelegate:self];
    [_calendarView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeFlightType:(id)sender
{
    currentSearchConditions.typeOfFlight = currentSearchConditions.typeOfFlight==econom?business:econom;
    [self setupTextForFlightTypeButton];
}
- (void)setupTextForFlightTypeButton
{
    NSString *title;
    if(currentSearchConditions.typeOfFlight==econom)
    {
        title = @"Эконом";
    }
    else
    {
        title = @"Бизнес";
    }
    
    [_flightClassButton setTitle: title forState: UIControlStateNormal];
    [_flightClassButton setTitle: title forState: UIControlStateHighlighted];
    [_flightClassButton setTitle: title forState: UIControlStateSelected];
}
- (IBAction)changeIsBothWays:(id)sender
{
    currentSearchConditions.isBothWays = _switchBoth.isOn;
}
- (void)setupSwitchBoth
{
    [_switchBoth setOn:currentSearchConditions.isBothWays];
}
- (SearchConditions*)getSearchConditions
{
    return currentSearchConditions;
}

#pragma mark CACalendarDelegate
- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    
    NSDate *dateCalendarTo = [calendarView getFlyToDate];
    NSDate *dateCalendarReturn = [calendarView getFlyReturnDate];
    if([CACalendarView compareDate:date and:[calendarView getFlyToDate]]==NSOrderedSame)
    {
        departureDate = date;
        if(returnDates.count==0)
        {
            [flightsManager getAvailableReturnDates:currentSearchConditions withDepartureDate:departureDate completeBlock:^(NSArray *array)
             {
                 returnDates = array;
                 [calendarView selectFlyReturnDaysByDateArray:returnDates];
             }];
        }
    }
    
    /*if(nil == [calendarView getFlyToDate])
    {
        if(currentSearchConditions.direction_departure!=nil&&currentSearchConditions.direction_return!=nil)
        {
            [flightsManager getAvailableDepartureDates:currentSearchConditions departureDate:departureDate completeBlock:^(NSArray *dates)
             {
                 departureDates = dates;
                 returnDates = [NSArray new];
                 [_calendarView resetSelections];
                 [self updateCalendarDates];
             }];
            
        }
    }
    else if(nil == [calendarView getFlyReturnDate])
    {
        [flightsManager getAvailableReturnDates:currentSearchConditions withDepartureDate:departureDate completeBlock:^(NSArray *array)
         {
             returnDates = array;
             [calendarView selectFlyReturnDaysByDateArray:returnDates];
         }];
    }

    else if([CACalendarView compareDate:date and:[calendarView getFlyToDate]]==NSOrderedSame)
    {
        departureDate = date;
        if(returnDates.count==0)
        {
            [flightsManager getAvailableReturnDates:currentSearchConditions withDepartureDate:departureDate completeBlock:^(NSArray *array)
             {
                    returnDates = array;
                 [calendarView selectFlyReturnDaysByDateArray:returnDates];
             }];
        }
    
    }
    if([CACalendarView compareDate:date and:[calendarView getFlyReturnDate]]==NSOrderedSame)
    {
        returnDate = date;
    }*/
}
- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    
}
#pragma mark CAFieldCompleteViewDelegate
-(void)fieldCompleteView:(CAFieldCompleteView *)fieldCompleteView selectedDestination:(Destination *)destination
{
    [self setupDestinationFrom:fieldCompleteView withValue:destination];
    
    if(currentSearchConditions.direction_departure!=nil&&currentSearchConditions.direction_return!=nil)
    {
        [flightsManager getAvailableDepartureDates:currentSearchConditions departureDate:[NSDate date] completeBlock:^(NSArray *dates)
         {
             departureDates = dates;
             [_calendarView resetSelections];
             [self updateCalendarDates];
             /*[flightsManager getAvailableReturnDates:currentSearchConditions withDepartureDate:[NSDate date] completeBlock:^(NSArray *arrayDates)
             {
                 returnDates = arrayDates;
                 
             }];*/
/*
             returnDates = [NSArray new];
             [_calendarView resetSelections];
             [self updateCalendarDates];*/
         }];
        
    }
    
    
}
-(void)fieldCompleteView:(CAFieldCompleteView *)fieldCompleteView textChanged:(NSString *)text
{
    [self setupDestinationFrom:fieldCompleteView withValue:nil];
    [self reloadDestinations:fieldCompleteView];}
-(void)fieldCompleteViewBeginEditing:(CAFieldCompleteView *)fieldCompleteView
{
    [self setupDestinationFrom:fieldCompleteView withValue:nil];
    [self reloadDestinations:fieldCompleteView];
}
-(void)reloadDestinations:(CAFieldCompleteView*) fieldCompleteView
{
    if(fieldCompleteView==_departureFieldView)
    {
        [citiesManager getDestinationsForDeparture:fieldCompleteView.text completeBlock:^(NSArray *citiesDeparture)
         {
             [_departureFieldView setAutocompleteData:citiesDeparture];
         }];
    }
    else
    {
        [citiesManager getDestinationsForReturn:fieldCompleteView.text forDepartureDestination:currentSearchConditions.direction_departure completeBlock:^(NSArray *array)
         {
             [_returnFieldView setAutocompleteData:array];
         }];
    }
}
-(void)setupDestinationFrom:(CAFieldCompleteView*) fieldCompleteView withValue:(Destination*) destination
{
    if(fieldCompleteView==_departureFieldView)
    {
        currentSearchConditions.direction_departure = destination;
    }
    else
    {
        currentSearchConditions.direction_return = destination;
    }
}
-(void)updateCalendarDates
{
    [_calendarView selectFlyToDaysByDateArray:departureDates];
 //   [_calendarView selectFlyReturnDaysByDateArray:returnDates];
}
@end
