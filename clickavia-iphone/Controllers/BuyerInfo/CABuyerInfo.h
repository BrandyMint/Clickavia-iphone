//
//  CABuyerInfo.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABuyerInfoCell.h"
#import "CABuyerPickerView.h"
#import "PersonInfo.h"
#import "FPPopoverController.h"
#import "CAPopoverList.h"
#import "WYPopoverController.h"

@interface CABuyerInfo : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CABuyerPickerViewDelegate, CABuyerInfoCellDelegate, FPPopoverControllerDelegate, CAPopoverListDelegate, WYPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CAPassportTextField* passportField;

@end
