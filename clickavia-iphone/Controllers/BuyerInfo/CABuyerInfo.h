//
//  CABuyerInfo.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPassportTextField.h"

@interface CABuyerInfo : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CAPassportTextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CAPassportTextField* passportField;


@end
