//
//  MyCell.h
//  TableView
//
//  Created by Alximik on 09.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "CAOffersListViewController.h"

#define CELL_HEIGHT_NORMAL 150
#define CELL_HEIGHT_SPECIAL 180
#define CELL_SPECIAL_PADDING (CELL_HEIGHT_SPECIAL-CELL_HEIGHT_NORMAL)/2
#define CELL_MARGIN_LEFT 5

@interface CAOffersCell : UITableViewCell
@property (nonatomic, retain) CAOffersListViewController* caOffersListViewController;


-(void)transferView:(UIView*) customView;
-(void)initByOfferModel:(Offer*)offers;

@end
