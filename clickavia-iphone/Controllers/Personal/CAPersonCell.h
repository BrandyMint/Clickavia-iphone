//
//  CAPersonCell.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 21/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialOfferCell.h"
#import "CAFlightPassengersCount.h"

@class CAPersonCell;
@protocol CAPersonCellDelegate
-(void)didselectTellManager:(NSInteger)numberOrder;
@end

@interface CAPersonCell: UITableViewCell {
    UILabel *orderNumber;
    UILabel *confirm;
    UILabel *detail;
}

@property (assign) id <CAPersonCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UILabel *orderNumber;
@property (nonatomic, strong) IBOutlet UILabel *confirm;
@property (nonatomic, strong) IBOutlet UILabel *detail;

- (void) orderNumber:(NSInteger)orderNumber specialOffer:(SpecialOffer* )specialOffer passengers:(CAFlightPassengersCount* )passengers;

@end
