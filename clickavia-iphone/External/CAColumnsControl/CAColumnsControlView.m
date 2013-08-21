//
//  CAColumnsControl.m
//  CAColumnsControl
//
//  Created by DenisDbv on 17.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import "CAColumnsControlView.h"
#import "CAScrollColumns.h"
#import "CACollectionScrollColumns.h"
#import <QuartzCore/QuartzCore.h>
#import "Flight.h"

@interface CAColumnsControlView()
@property (nonatomic, retain) CAScrollColumns *scrollColumns;
@property (nonatomic, retain) CACollectionScrollColumns *collectionScrollColumns;
@end

@implementation CAColumnsControlView
{
    NSMutableArray *newFlightData;
    ColumnControlType controlType;
    UILabel *monthStateLabel;
    NSArray *monthTitleArray;
}

@synthesize scrollColumns;
@synthesize collectionScrollColumns;
@synthesize delegate;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame type:(ColumnControlType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        monthTitleArray = [[NSArray alloc] initWithObjects:@"", @"Январь", @"Февраль", @"Март", @"Апрель", @"Май", @"Июнь", @"Июль", @"Август",
                                                            @"Сентябрь", @"Октябрь", @"Ноябрь", @"Декабрь", nil];
        
        controlType = type;
        
        [self setBackgroundColorView];
        
        [self initScrollView];
    }
    return self;
}

- (void)scrollColumns:(CACollectionScrollColumns *)columnScrollView didSelectColumnWithObject:(Flight*)flight
{
    if([delegate respondsToSelector:@selector(columnsControlView:didSelectColumnWithObject:)])
    {
        [delegate columnsControlView:self didSelectColumnWithObject:flight];
    }
}

- (void)scrollColumnsChangeMonth:(CAScrollColumns *)columnScrollView onDate:(NSDate*)date
{
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date];
    monthStateLabel.text = [NSString stringWithFormat:@"%@ %i", [monthTitleArray objectAtIndex:dateComps.month], dateComps.year];
    [self redrawMonthState];
}

-(void) reloadData:(NSArray*)data
{
    NSInteger maxCost = 0;
    
    newFlightData = [[NSMutableArray alloc] init];
    
    //Отсортировать по возрастанию даты
    NSSortDescriptor* sd = [[NSSortDescriptor alloc] initWithKey:@"dateAndTimeDeparture" ascending:YES];
    NSArray *sortedFlightArray = [data sortedArrayUsingDescriptors:[NSArray arrayWithObject:sd]];
    
    //Найти дату из массива схожих дат и выбрать самую дешевую
    for (Flight *flight in sortedFlightArray) {
        
        NSPredicate* pred = [NSPredicate predicateWithFormat:@"dateAndTimeDeparture == %@", flight.dateAndTimeDeparture];
        
        if([newFlightData filteredArrayUsingPredicate:pred].count == 0)
        {
            NSArray *monthFlightArray = [data filteredArrayUsingPredicate:pred];
            NSArray *sortedCheapFlights = [monthFlightArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sd]];
            
            Flight *cheapFlight = [sortedCheapFlights objectAtIndex:0];
            [newFlightData addObject:cheapFlight];
            
            //Находим максимальную цену
            if([cheapFlight.price integerValue] > maxCost)
                maxCost = [cheapFlight.price integerValue];
        }
    }
    
    [collectionScrollColumns addDataToScroll:newFlightData withMaxCost:maxCost];
}

-(void) setBackgroundColorView
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    UIColor *darkColor = [UIColor colorWithRed:0.0706f green:0.1529f blue:0.4235f alpha:1.0f];
    UIColor *lightColor = [UIColor colorWithRed:0.258f green:0.639f blue:0.890f alpha:1.0f];
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    [mutableColors addObject:(id)lightColor.CGColor];
    [mutableColors addObject:(id)darkColor.CGColor];
    
    layer.colors = mutableColors;
}

-(void) initScrollView
{
    collectionScrollColumns = [[CACollectionScrollColumns alloc] initWithFrame:self.bounds];
    collectionScrollColumns.delegateScroll = (id)self;
    [self addSubview:collectionScrollColumns];
    
    [self drawControlType];
    [self drawMonthState];
}

-(void) drawControlType
{
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    costLabel.font = [UIFont fontWithName:@"Arial" size:13];
    costLabel.backgroundColor = [UIColor clearColor];
    costLabel.textColor = [UIColor lightGrayColor];
    costLabel.text = (controlType == caDepartureType)?@"туда":@"обратно";
    [costLabel sizeToFit];
    
    costLabel.frame = CGRectMake(10, 7, costLabel.frame.size.width, costLabel.frame.size.height);
    [self addSubview:costLabel];
}

-(void) drawMonthState
{
    monthStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    monthStateLabel.font = [UIFont fontWithName:@"Arial" size:15];
    monthStateLabel.backgroundColor = [UIColor clearColor];
    monthStateLabel.textColor = [UIColor whiteColor];
    monthStateLabel.text = @"";
    [monthStateLabel sizeToFit];
    
    monthStateLabel.frame = CGRectMake((self.frame.size.width-monthStateLabel.frame.size.width)/2, 6, monthStateLabel.frame.size.width, monthStateLabel.frame.size.height);
    [self addSubview:monthStateLabel];
}

-(void) redrawMonthState
{
    [monthStateLabel sizeToFit];
    monthStateLabel.frame = CGRectMake((self.frame.size.width-monthStateLabel.frame.size.width)/2, 6, monthStateLabel.frame.size.width, monthStateLabel.frame.size.height);
}

@end
