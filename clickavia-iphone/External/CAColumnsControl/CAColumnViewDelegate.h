//
//  CAColumnViewDelegate.h
//  CAColumnsControl
//
//  Created by DenisDbv on 19.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#ifndef CAColumnsControl_CAColumnViewDelegate_h
#define CAColumnsControl_CAColumnViewDelegate_h

@class CAColumnView;
@class Flight;

@protocol CAColumnViewDelegate <NSObject>

- (void)columnView:(CAColumnView *)columnView didSelectColumnWithObject:(Flight*)flight;

@end

#endif
