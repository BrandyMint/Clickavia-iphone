//
//  CAColumnsControlViewDelegate.h
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 17.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#ifndef CAColumnsControl_CAColumnsControlViewDelegate_h
#define CAColumnsControl_CAColumnsControlViewDelegate_h

@class Flight;
@class CAColumnsControlView;

@protocol CAColumnsControlViewDelegate <NSObject>

- (void)columnsControlView:(CAColumnsControlView *)columnsControlView didSelectColumnWithObject:(Flight*)flight;

@end

#endif
