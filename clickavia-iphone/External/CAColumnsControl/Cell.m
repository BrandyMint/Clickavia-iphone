//
//  Cell.m
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 22.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import "Cell.h"

@interface Cell()
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *dayOfWeekLabel;
@property (nonatomic, strong) UILabel *costLabel;
@end

@implementation Cell
{
    UILabel *costLabel;
    NSString *dayText;
    NSString *dayOfWeekText;
}
@synthesize flight;
@synthesize dayLabel, dayOfWeekLabel, costLabel;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dayLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:13];
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.textColor = [UIColor blackColor];
        
        dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dayOfWeekLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:13];
        dayOfWeekLabel.backgroundColor = [UIColor clearColor];
        dayOfWeekLabel.textColor = [UIColor blackColor];
        
        costLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        costLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:13];
        costLabel.backgroundColor = [UIColor clearColor];
        costLabel.textColor = [UIColor lightTextColor];
        
        [self addSubview:dayLabel];
        [self addSubview:dayOfWeekLabel];
        [self addSubview:costLabel];
    }
    return self;
}

-(void) reloadColumn
{
    [self drawDayAndDayOfWeek];
    //[self performSelectorOnMainThread:@selector(drawDayAndDayOfWeek) withObject:nil waitUntilDone:NO];
    
    if(![self isClearFlight])   {
        [self unselectBackgroundColorView];
        
        //[self performSelectorOnMainThread:@selector(drawCost) withObject:nil waitUntilDone:NO];
        [self drawCost];
    }
    else
    {
        CAGradientLayer *layer = (CAGradientLayer *)self.layer;
        layer.colors = nil;
        costLabel.text = @"";
    }
}

-(BOOL) isClearFlight
{
    if([flight.price integerValue] == 0)
        return YES;
    else
        return NO;
}

-(void) unselectBackgroundColorView
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    UIColor *darkColor = [UIColor colorWithRed:0.0706f green:0.7529f blue:0.1235f alpha:1.0f];
    UIColor *lightColor = [UIColor colorWithRed:0.758f green:0.639f blue:0.890f alpha:1.0f];
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    [mutableColors addObject:(id)lightColor.CGColor];
    [mutableColors addObject:(id)darkColor.CGColor];
    
    layer.colors = mutableColors;
    
    costLabel.textColor = [UIColor lightTextColor];
}

-(void) selectBackgroundColorView
{
    if(![self isClearFlight])   {
        CAGradientLayer *layer = (CAGradientLayer *)self.layer;
        
        UIColor *darkColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        UIColor *lightColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
        [mutableColors addObject:(id)lightColor.CGColor];
        [mutableColors addObject:(id)darkColor.CGColor];
        
        layer.colors = mutableColors;
        
        costLabel.textColor = [UIColor whiteColor];
    }
}

-(void) drawDayAndDayOfWeek
{
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:flight.dateAndTimeDeparture];
    
    dayLabel.text = [NSString stringWithFormat:@"%i", dateComps.day];
    [dayLabel sizeToFit];
    dayLabel.frame = CGRectMake((self.frame.size.width-dayLabel.frame.size.width)/2, (self.frame.size.height - dayLabel.frame.size.height)+2, dayLabel.frame.size.width, dayLabel.frame.size.height);
    
    dayOfWeekLabel.text = [self dayOfWeek:flight.dateAndTimeDeparture];
    [dayOfWeekLabel sizeToFit];
    dayOfWeekLabel.frame = CGRectMake((self.frame.size.width-dayOfWeekLabel.frame.size.width)/2, (dayLabel.frame.origin.y-dayOfWeekLabel.frame.size.height+3), dayOfWeekLabel.frame.size.width, dayOfWeekLabel.frame.size.height);
}

-(void) drawCost
{
    costLabel.text = [NSString stringWithFormat:@"%i", [flight.price integerValue]];
    [costLabel sizeToFit];
    costLabel.frame = CGRectMake((self.frame.size.width-costLabel.frame.size.width)/2, -(costLabel.frame.size.height)+2, costLabel.frame.size.width, costLabel.frame.size.height);
}

-(NSString*) dayOfWeek:(NSDate*)date
{
	NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
	[nowDateFormatter setDateFormat:@"e"];
    NSArray *daysOfWeek = @[@"",@"ВC",@"ПН",@"ВТ",@"СР",@"ЧТ",@"ПТ",@"СБ"];
	NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:date] integerValue];
    
    return [daysOfWeek objectAtIndex:weekdayNumber];
}


@end
