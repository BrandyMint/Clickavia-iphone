//
//  CACollectionScrollColumns.h
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 22.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PSTCollectionView/PSTCollectionView.h>
#import "CAScrollColumnsDelegate.h"

@interface CACollectionScrollColumns : UIView <PSUICollectionViewDataSource, PSUICollectionViewDelegate>

@property (retain, nonatomic) PSUICollectionView *collectionView;
@property (nonatomic, retain) id delegateScroll;

-(void) initCollectionView;
-(void) addDataToScroll:(NSArray*)columsArray withMaxCost:(NSInteger)maxCost;

@end
