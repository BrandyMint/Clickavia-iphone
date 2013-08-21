//
//  CAColumnsControl.h
//  CAColumnsControl
//
//  Created by DenisDbv on 17.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAColumnsControlViewDelegate.h"
#import "CAScrollColumnsDelegate.h"

typedef enum {
    caDepartureType,
    caArrivialType
} ColumnControlType;

@interface CAColumnsControlView : UIView <CAScrollColumnsDelegate>

@property (nonatomic, weak) id <CAColumnsControlViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame type:(ColumnControlType)type;
-(void) reloadData:(NSArray*)data;

@end
