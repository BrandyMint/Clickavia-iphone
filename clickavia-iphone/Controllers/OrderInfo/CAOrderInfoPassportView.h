//
//  CAOrderInfoPassportView.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 19/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfo.h"

#define MARGIN_LEFT 10
#define MARGIN_BETWEEN_LABELS 5

@interface CAOrderInfoPassportView : UIView

- (UIView* )initWithpersonInfo:(PersonInfo*)_personInfo;

@end
