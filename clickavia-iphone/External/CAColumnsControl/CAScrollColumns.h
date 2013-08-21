//
//  CAScrollColumns.h
//  CAColumnsControl
//
//  Created by DenisDbv on 17.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAColumnViewDelegate.h"
#import "CAScrollColumnsDelegate.h"

@interface CAScrollColumns : UIScrollView <CAColumnViewDelegate>

@property (nonatomic, retain) id delegateScroll;
@property (nonatomic, retain) NSMutableArray *coordMonthStart;

-(void) addDataToScroll:(NSArray*)columsArray withMaxCost:(NSInteger)maxCost;
-(void) removeAllColumns;

@end
