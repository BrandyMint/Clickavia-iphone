//
//  CAAutorizedController.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 12/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "CAReplacePassportCard.h"

@interface CAAutorizedController : UIViewController <CAPassportTextFieldDelegate, UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(User* )user;

@end
