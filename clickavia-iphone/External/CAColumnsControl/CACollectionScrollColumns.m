//
//  CACollectionScrollColumns.m
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 22.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import "CACollectionScrollColumns.h"
#import "Cell.h"
#import "Flight.h"

@implementation CACollectionScrollColumns
{
    NSMutableArray *_columnArray;
    NSInteger _maxCost;
    NSIndexPath *selectColumn;
}
@synthesize collectionView;
@synthesize delegateScroll;

static NSString *CollectionViewCellIdentifier = @"Column";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        selectColumn = nil;
        
        [self initCollectionView];
        
    }
    return self;
}

-(void) addDataToScroll:(NSArray*)columsArray withMaxCost:(NSInteger)maxCost
{
    _maxCost = maxCost;
    //_columnArray = columsArray;
    _columnArray = [[NSMutableArray alloc] init];
    
    [self performSelectorInBackground:@selector(calculate:) withObject:columsArray];
    //[self calculate: columsArray];
}

-(void) calculate:(NSArray*)columsArray
{
    NSInteger columnsCount = [columsArray count];
    Flight *firstFlight = [columsArray objectAtIndex:0];
    
    [_columnArray addObject: firstFlight];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:firstFlight.dateAndTimeDeparture];
    NSLog(@"%i/%i/%i", dateComps.day, dateComps.month, dateComps.year);
    
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
            
            [_columnArray addObject: columnFlight];
            
            dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:columnFlight.dateAndTimeDeparture];
            NSLog(@"%i/%i/%i", dateComps.day, dateComps.month, dateComps.year);
        }
        
        [_columnArray addObject: secondFlight];
        firstFlight = secondFlight;
        
        dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:secondFlight.dateAndTimeDeparture];
        NSLog(@"%i/%i/%i", dateComps.day, dateComps.month, dateComps.year);
    }
    
    [collectionView reloadData];
}

-(void) initCollectionView
{
    PSUICollectionViewFlowLayout *layout = [[PSUICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collectionView = [[PSUICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = (id)self;
    collectionView.dataSource = (id)self;
    collectionView.contentMode = UIViewContentModeBottomLeft;
    [collectionView registerClass:[Cell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    [self addSubview:collectionView];
}

#pragma mark -
#pragma mark PSUICollectionView stuff

- (NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView {
    return [_columnArray count];
}

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Flight *flight = [_columnArray objectAtIndex:indexPath.section];
    NSInteger realHeight = [flight.price integerValue]*(self.frame.size.height-50)/_maxCost;
    
    if(realHeight == 0)
        realHeight = 50;
    
    return CGSizeMake(40, realHeight);
}

- (UIEdgeInsets)collectionView:(PSTCollectionView *)collectionView layout:(PSTCollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    Flight *flight = [_columnArray objectAtIndex:section];
    NSInteger realHeight = [flight.price integerValue]*(self.frame.size.height-50)/_maxCost;
    
    if(realHeight == 0)
        realHeight = 50;
    
    if(section < _columnArray.count-1)    {
        return UIEdgeInsetsMake(self.bounds.size.height-realHeight, 1, 1, 0);
    }
    else
    {
        return UIEdgeInsetsMake(self.bounds.size.height-realHeight, 1, 1, 1);
    }
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = (Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.flight = [_columnArray objectAtIndex:indexPath.section];
    [cell reloadColumn];
    
    if([indexPath isEqual:selectColumn])    {
        [cell selectBackgroundColorView];
    }
    
    return cell;
}

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Flight *flight = [_columnArray objectAtIndex:indexPath.section];
    
    if([flight.price integerValue] == 0) return;    //Не разрешаем выделять столбцы с нулевой ценой
    
    if(selectColumn != nil) {
        Cell *cell = [collectionView cellForItemAtIndexPath:selectColumn];
        [cell unselectBackgroundColorView];
    }
    
    selectColumn = indexPath;
    
    Cell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell selectBackgroundColorView];
    
    if([delegateScroll respondsToSelector:@selector(scrollColumns:didSelectColumnWithObject:)])
    {
        [delegateScroll scrollColumns:self didSelectColumnWithObject:flight];
    }
}

@end
