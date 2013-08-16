//
//  CAFCStyle.h
//  cafieldcomplete
//
//  Created by macmini1 on 31.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAFCStyle : NSObject
+ (CAFCStyle *) sharedStyle;
- (UIColor*) colorForDestinationName;
- (UIColor*) colorForDestinationCode;
- (UIFont*) fontForDestinationName;
- (UIFont*) fontForDestinationCode;
//table customization
- (NSArray*) gradientColorsForTable;
- (UIImage*) imageForBackgroundForTable;
- (CGFloat) cornerRadiusForTable;
- (CGFloat) codeLabelCenterOffsetForCell;
//text field customization
- (NSArray*) gradientColorsForTextField;
- (UIImage*) imageForBackgroundForTextField;
- (CGFloat) codeLabelCenterOffsetForTextField;
- (CGFloat) cornerRadiusForTextField;

//triangle customization
- (UIColor*) colorForTriangleView;
@end
