//
//  CAColumnView.m
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 18.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import "CAColumnView.h"
#import <QuartzCore/QuartzCore.h>

@interface CAColumnView()
@property (nonatomic, retain) Flight *flight;
@end

@implementation CAColumnView
{
    UILabel *costLabel;
    NSString *dayText;
    NSString *dayOfWeekText;
}
@synthesize flight;
@synthesize delegate;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame byObject:(Flight*)flightObject
{
    self = [super initWithFrame:frame];
    if (self) {
        flight = flightObject;

        self.userInteractionEnabled = YES;
        
        [self drawDayAndDayOfWeek];
        //[self performSelectorOnMainThread:@selector(drawDayAndDayOfWeek) withObject:nil waitUntilDone:NO];
        
        if(![self isClearFlight])   {
            [self unselectBackgroundColorView];
    
            //[self performSelectorOnMainThread:@selector(drawCost) withObject:nil waitUntilDone:NO];
            [self drawCost];
        }
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
}

/*- (void)drawRect:(CGRect)iRect {
    [super drawRect:iRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    //CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    //CGContextAddPath(context, path);
    CGContextFillPath(context);
    [[NSString stringWithFormat:@"%i", [flight.price integerValue]] drawInRect:CGRectMake(iRect.origin.x, iRect.origin.y, iRect.size.width, iRect.size.height) withFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:13]];
    [dayText drawInRect:CGRectMake(iRect.origin.x, iRect.origin.y+10, iRect.size.width, iRect.size.height) withFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:13]];
    [dayOfWeekText drawInRect:CGRectMake(iRect.origin.x, iRect.origin.y+30, iRect.size.width, iRect.size.height) withFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:13]];
    CGContextRestoreGState(context);
}*/

-(void) includeTapGesture
{
    UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UIGestureRecognizer *)singleTap
{
    NSLog(@"single tap on column");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if([delegate respondsToSelector:@selector(columnView:didSelectColumnWithObject:)])
    {
        [delegate columnView:self didSelectColumnWithObject:flight];
    }
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
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    UIColor *darkColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    UIColor *lightColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    [mutableColors addObject:(id)lightColor.CGColor];
    [mutableColors addObject:(id)darkColor.CGColor];
    
    layer.colors = mutableColors;
    
    costLabel.textColor = [UIColor whiteColor];
}

-(BOOL) isClearFlight
{
    if([flight.price integerValue] == 0)
        return YES;
    else
        return NO;
}

-(void) drawDayAndDayOfWeek
{
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:flight.dateAndTimeDeparture];
    
    /*dayText = [NSString stringWithFormat:@"%i", dateComps.day];
    dayOfWeekText = [self dayOfWeek:flight.dateAndTimeDeparture];
    [self setNeedsDisplay];*/
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dayLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:13];
    dayLabel.backgroundColor = [UIColor clearColor];
    dayLabel.textColor = [UIColor blackColor];
    dayLabel.text = [NSString stringWithFormat:@"%i", dateComps.day];
    [dayLabel sizeToFit];
    
    dayLabel.frame = CGRectMake((self.frame.size.width-dayLabel.frame.size.width)/2, -(dayLabel.frame.size.height), dayLabel.frame.size.width, dayLabel.frame.size.height);
    [self addSubview:dayLabel];
    
    UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dayOfWeekLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:13];
    dayOfWeekLabel.backgroundColor = [UIColor clearColor];
    dayOfWeekLabel.textColor = [UIColor blackColor];
    dayOfWeekLabel.text = [self dayOfWeek:flight.dateAndTimeDeparture];
    [dayOfWeekLabel sizeToFit];
    
    dayOfWeekLabel.frame = CGRectMake((self.frame.size.width-dayOfWeekLabel.frame.size.width)/2, (dayLabel.frame.origin.y-dayOfWeekLabel.frame.size.height+3), dayOfWeekLabel.frame.size.width, dayOfWeekLabel.frame.size.height);
    [self addSubview:dayOfWeekLabel];
}

-(void) drawCost
{
    costLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    costLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:13];
    costLabel.backgroundColor = [UIColor clearColor];
    costLabel.textColor = [UIColor lightTextColor];
    costLabel.text = [NSString stringWithFormat:@"%i", [flight.price integerValue]];
    [costLabel sizeToFit];
    
    costLabel.frame = CGRectMake((self.frame.size.width-costLabel.frame.size.width)/2, -(self.frame.size.height+costLabel.frame.size.height), costLabel.frame.size.width, costLabel.frame.size.height);
    [self addSubview:costLabel];
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
