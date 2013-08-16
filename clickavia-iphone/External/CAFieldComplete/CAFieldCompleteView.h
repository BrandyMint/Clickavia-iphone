//
//  CAFieldComplete.h
//  cafieldcomplete
//
//  Created by macmini1 on 29.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAFCTextField.h"
#import "CAFCTriangleView.h"
#import "CAFCTableViewCell.h"

#import "Destination.h"

@class CAFieldCompleteView;
@protocol CAFieldCompleteViewDelegate
- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView selectedDestination:(Destination*) destination;
- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView textChanged:(NSString*) text;
- (void)fieldCompleteViewBeginEditing:(CAFieldCompleteView *)fieldCompleteView;
@end
@interface CAFieldCompleteView : UIView <UITableViewDataSource,CATextFieldCompleteDelegate,UITableViewDelegate>
{
    CAFCTextField *textField;
    CAFCTriangleView *triangleView;
    UITableView *autocompleteTable;
    NSArray *destinations;
    CGRect oldFrame;
    BOOL textFieldActive;
    
    CAGradientLayer *tableGradientLayer;
    NSArray *tableGradientColors;
    UIImageView *tableBackground;
}
@property (assign) id <CAFieldCompleteViewDelegate> delegate;
@property BOOL isReturn;
- (void)setAutocompleteData:(NSArray*) autocompleteArray;
- (NSString*) text;
@end
