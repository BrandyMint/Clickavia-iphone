//
//  CAPersonalViewController.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 21/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "CAPersonCell.h"

@interface CAPersonalViewController : UIViewController <CAPersonCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
