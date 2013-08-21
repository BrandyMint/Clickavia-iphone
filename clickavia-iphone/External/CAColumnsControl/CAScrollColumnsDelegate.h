//
//  CAScrollColumnsDelegate.h
//  CAColumnsControl
//
//  Created by DenisDbv on 19.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#ifndef CAColumnsControl_CAScrollColumnsDelegate_h
#define CAColumnsControl_CAScrollColumnsDelegate_h

@class CACollectionScrollColumns;
@class Flight;

@protocol CAScrollColumnsDelegate <NSObject>

- (void)scrollColumns:(CACollectionScrollColumns *)columnScrollView didSelectColumnWithObject:(Flight*)flight;
- (void)scrollColumnsChangeMonth:(CACollectionScrollColumns *)columnScrollView onDate:(NSDate*)date;

@end


#endif
