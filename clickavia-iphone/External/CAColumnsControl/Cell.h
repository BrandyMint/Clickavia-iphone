//
//  Cell.h
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 22.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PSTCollectionView/PSTCollectionView.h>
#import "Flight.h"

@interface Cell : PSUICollectionViewCell

@property (nonatomic, retain) Flight *flight;

-(void) reloadColumn;
-(void) unselectBackgroundColorView;
-(void) selectBackgroundColorView;

@end
