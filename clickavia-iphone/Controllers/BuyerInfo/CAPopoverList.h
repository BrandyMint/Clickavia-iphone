//
//  CAPopoverList.h
//  clickavia-iphone
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAPopoverList;
@protocol CAPopoverListDelegate
-(void)popoverListdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CAPopoverList : UITableViewController

@property (assign) id <CAPopoverListDelegate> delegate;
-(id)initWithStyle:(UITableViewStyle)style arrayValues:(NSArray*)arrayValues;
-(void)heightRow:(float)heightRow;
-(void)title:(NSString* )title;
@end
