//
//  CAScrollColumns.m
//  CAColumnsControl
//
//  Created by DenisDbv on 17.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import "CAScrollColumns.h"
#import "Flight.h"
#import "CAColumnView.h"

@implementation CAScrollColumns
{
    UIView *substrateView;
    NSInteger leftSpace;
    NSInteger _maxCost;
    UIView *_oldView;
    NSDate *startDate;
    NSInteger numberOfColumnsInScreen;
}

@synthesize delegateScroll;
@synthesize coordMonthStart;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftSpace = 0;
        
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = (id)self;
    }
    return self;
}

- (void)columnView:(CAColumnView *)columnView didSelectColumnWithObject:(Flight*)flight;
{
    if(_oldView != nil) {
        [((CAColumnView*)_oldView) unselectBackgroundColorView];
    }
    
    _oldView = columnView;
    
    [((CAColumnView*)_oldView) selectBackgroundColorView];

    if([delegateScroll respondsToSelector:@selector(scrollColumns:didSelectColumnWithObject:)])
    {
        [delegateScroll scrollColumns:self didSelectColumnWithObject:flight];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    [self calculateCurrentColumn];
    
    CGFloat scrollOfs = self.contentOffset.x;
    
    int curColumnIndex = floor(scrollOfs/(COLUMN_WIDTH+COLUMNS_MARGIN));
    int curBlockIndex = floor(curColumnIndex/8);

    int staticCurColumnIndex = curColumnIndex - (curBlockIndex*8);
    //int staticCurBlockIndex = floor(3/curBlockIndex);
}

-(void) calculateCurrentColumn
{
    CGFloat scrollOfs = self.contentOffset.x;
    
    int curColumnIndex = floor(scrollOfs/COLUMN_ALL_WIDTH) + numberOfColumnsInScreen/2;
    
    NSDate *curDate = [startDate dateByAddingTimeInterval:curColumnIndex*24*60*60];
    //NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:curDate];
    //if(dateComps.day == 1)
    //{
        if([delegateScroll respondsToSelector:@selector(scrollColumnsChangeMonth:onDate:)])
        {
            [delegateScroll scrollColumnsChangeMonth:self onDate:curDate];
        }
    //}
}

-(void) addDataToScroll:(NSArray*)columsArray withMaxCost:(NSInteger)maxCost
{
    leftSpace = 0;
    startDate = ((Flight*)[columsArray objectAtIndex:0]).dateAndTimeDeparture;
    
    numberOfColumnsInScreen = self.frame.size.width/((COLUMN_WIDTH+COLUMNS_MARGIN)+COLUMNS_MARGIN) + 1;
    
    if([delegateScroll respondsToSelector:@selector(scrollColumnsChangeMonth:onDate:)])
    {
        [delegateScroll scrollColumnsChangeMonth:self onDate:startDate];
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        substrateView.alpha = 0;
    } completion:^(BOOL finished) {
        [substrateView removeFromSuperview];
        
        substrateView = [[UIView alloc] initWithFrame:self.bounds];
        substrateView.alpha = 1.0f;
        [self addSubview:substrateView];
        
        _maxCost = maxCost;
        
        [self performSelectorInBackground:@selector(calculate:) withObject:columsArray];
        /*NSInteger columnsCount = [columsArray count];
        Flight *firstFlight = [columsArray objectAtIndex:0];
        [self addColumnBar: firstFlight];
        for(int loop = 1; loop < columnsCount; loop++)
        {
            Flight *secondFlight = [columsArray objectAtIndex:loop];
            
            //NSInteger daysBetweenDays = [self daysBetweenDate:firstFlight.dateAndTimeDeparture andDate:secondFlight.dateAndTimeDeparture];
            //NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:firstFlight.dateAndTimeDeparture];
            //NSLog(@"%i/%i/%i", dateComps.day, dateComps.month, dateComps.year);
            
            NSDate *startDate = [firstFlight.dateAndTimeDeparture dateByAddingTimeInterval:86400];
            NSDate *endDate = secondFlight.dateAndTimeDeparture;
            NSDate *nextDate = nil;
            for ( nextDate = startDate ; [nextDate compare:endDate] < 0 ; nextDate = [nextDate dateByAddingTimeInterval:86400] )
            {
                Flight *columnFlight = [[Flight alloc] init];
                columnFlight.dateAndTimeDeparture = nextDate;
                [self addColumnBar: columnFlight];
                
                //NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:nextDate];
                //NSLog(@"=> %i/%i/%i", dateComps.day, dateComps.month, dateComps.year);
            }
            
            [self addColumnBar: secondFlight];
            firstFlight = secondFlight;
        }*/
    }];
}

-(void) calculate:(NSArray*)columsArray
{    
    NSInteger columnsCount = [columsArray count];
    Flight *firstFlight = [columsArray objectAtIndex:0];
    [self addColumnBar: firstFlight];
    for(int loop = 1; loop < columnsCount; loop++)
    {
        Flight *secondFlight = [columsArray objectAtIndex:loop];
        
        NSDate *startDate = [firstFlight.dateAndTimeDeparture dateByAddingTimeInterval:86400];
        NSDate *endDate = secondFlight.dateAndTimeDeparture;
        NSDate *nextDate = nil;
        for ( nextDate = startDate ; [nextDate compare:endDate] < 0 ; nextDate = [nextDate dateByAddingTimeInterval:86400] )
        {
            Flight *columnFlight = [[Flight alloc] init];
            columnFlight.dateAndTimeDeparture = nextDate;
            
            [self performSelectorOnMainThread:@selector(addData:) withObject:columnFlight waitUntilDone:NO];
            //[self addColumnBar: columnFlight];
        }
        
        [self performSelectorOnMainThread:@selector(addData:) withObject:secondFlight waitUntilDone:NO];
        //[self addColumnBar: secondFlight];
        firstFlight = secondFlight;
    }
}

-(void) addData:(Flight*)columnFlight
{
    [self addColumnBar: columnFlight];
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

-(void) addColumnBar:(Flight*)flight
{
    NSInteger realHeight = [flight.price integerValue]*(self.frame.size.height-50)/_maxCost;
    
    CAColumnView *columnView = [[CAColumnView alloc] initWithFrame:CGRectMake(leftSpace*(COLUMN_WIDTH+COLUMNS_MARGIN)+COLUMNS_MARGIN, self.frame.size.height-1, COLUMN_WIDTH, -(realHeight+1)) byObject:flight];
    columnView.delegate = (id)self;
    columnView.backgroundColor = [UIColor clearColor];
    [substrateView addSubview:columnView];
    
    leftSpace++;
    
    [self setContentWidth:leftSpace*(COLUMN_WIDTH+COLUMNS_MARGIN)+COLUMNS_MARGIN];
}

-(void) setContentWidth:(NSInteger)space
{
    self.contentSize = CGSizeMake(space, self.contentSize.height);
    substrateView.frame = CGRectMake(substrateView.frame.origin.x, substrateView.frame.origin.y, self.contentSize.width, substrateView.frame.size.height);
}

-(void) removeAllColumns
{
    leftSpace = 0;
    
    [UIView animateWithDuration:0.3f animations:^{
        substrateView.alpha = 0;
    } completion:^(BOOL finished) {
        [substrateView removeFromSuperview];
    }];
}

@end
