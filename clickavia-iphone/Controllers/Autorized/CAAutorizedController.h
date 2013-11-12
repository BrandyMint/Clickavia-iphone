//
//  CAAutorizedController.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 12/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CAAutorizedController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(User* )user;

@end
