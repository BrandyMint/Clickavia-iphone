//
//  CAOrderInfo.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 19/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface CAOrderInfo : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil passports:(NSArray* )passports offer:(Offer*)offer;

@end
