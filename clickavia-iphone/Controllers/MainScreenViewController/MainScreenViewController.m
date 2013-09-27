//
//  MainScreenViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topGreenImage;

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
    
    _calendarView.frame = CGRectMake(0, 100, self.view.frame.size.width, 380);
    _departureCompleteView.backgroundColor = [UIColor orangeColor];
    
    [_calendarView setDelegate:self];
    [_calendarView selectFlyToDaysByDateArray:[CACalendarMockDates generateFlyToDates]];
    [_calendarView selectFlyReturnDaysByDateArray:[CACalendarMockDates generateFlyReturnDates:[NSDate date]]];
    
    ///autocomplete
    
    _departureCompleteView.frame = CGRectMake(1, 10, _departureCompleteView.frame.size.width, _departureCompleteView.frame.size.height);
    _returnCompleteView.frame = CGRectMake(_departureCompleteView.frame.origin.x + _departureCompleteView.frame.size.width + 9, 10, _departureCompleteView.frame.size.width, _departureCompleteView.frame.size.height);
    
    _cm = [CitiesManager new];
    _cm.delay = 500;
    _departureDestination = [Destination new];
    _returnDestination = [Destination new];
    
    _departureCompleteView.offsetTopForAutocomplete = 60;
    _departureCompleteView.offsetLeftTriangleForAutocomplete = 40;
    [_departureCompleteView setIsDeparture:YES];
    
    _returnCompleteView.offsetTopForAutocomplete = 60;
    _returnCompleteView.offsetLeftTriangleForAutocomplete = self.view.frame.size.width-60;
    [_returnCompleteView setIsDeparture:NO];
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

- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    if(_calendarView.flyToDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            NSLog(@"Была выбрана дата вылета");
        }
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSLog(@"IPAD");
    }
    else
    {
        NSLog(@"IPhone");
    }
    
    NSLog([date description]);
}
- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    NSLog([date description]);
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

- (IBAction)find:(id)sender
{
    //[self getOfferConditions];
}
@end
