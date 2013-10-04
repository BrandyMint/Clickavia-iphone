//
//  CASearchFormClassView.m
//  CASearchForm
//
//  Created by macmini2 on 11.09.13.
//  Copyright (c) 2013 easy-pro. All rights reserved.
//

#import "CATooltipSelect.h"

@implementation CATooltipSelect
{
    UIView *boxView;
    UITableView *classTable;
    
    UIImage *checkClassSelectorImage;
    
    NSArray* arrayOfStrings;
    CGFloat heightForRowAtIndexPath;
    CGFloat widthTableBorder;
}

- (id)initWithFrame:(CGRect)frame widthTableBorder:(CGFloat)height;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        widthTableBorder = height;
        [self baseSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        // Initialization code
        [self baseSetup];
    }
    return self;
}

- (void) baseSetup
{
    [self setBackgroundColor: [UIColor clearColor]];

    boxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [boxView setBackgroundColor:[UIColor grayColor]];
    
    [self addSubview:boxView];
     
    classTable = [[UITableView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, boxView.frame.size.width, boxView.frame.size.height), widthTableBorder, 10)];
    classTable.dataSource = self;
    classTable.delegate = self;
    classTable.backgroundColor = [UIColor whiteColor];
    
    classTable.layer.cornerRadius = 6;
    
    boxView.layer.cornerRadius = 10;
    
    [classTable setScrollEnabled:NO];
    
    [boxView addSubview:classTable];
}

- (void) setFrameForTrianglePlace: (CGRect)frame
{
    CASearchFormTriangleView *triangle = [[CASearchFormTriangleView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    [triangle setTriangleColor:[boxView backgroundColor]];
    triangle.backgroundColor = [UIColor orangeColor];
    [self addSubview:triangle];
    
    boxView.frame = CGRectMake(0, triangle.frame.size.height, boxView.frame.size.width, boxView.frame.size.height);
    
    classTable.frame = CGRectInset(CGRectMake(0, 0, boxView.frame.size.width, boxView.frame.size.height), 10, 10);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, triangle.frame.size.height + boxView.frame.size.height);
}

- (void) setCheckClassSelectorImage: (UIImage*)image
{
    checkClassSelectorImage = image;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayOfStrings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CASearchFormClassCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[CASearchFormClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = [arrayOfStrings objectAtIndex:indexPath.row];
    }
    
    [cell setCheckImage:checkClassSelectorImage];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < arrayOfStrings.count; i++) {
        [(CASearchFormClassCell *)[classTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setChecked:NO];
    }
    [(CASearchFormClassCell *)[classTable cellForRowAtIndexPath:indexPath] setChecked:YES];
    [_delegate paymentTableView:self currentPayment:[arrayOfStrings objectAtIndex:indexPath.row]];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightForRowAtIndexPath;
}

- (void) valuesTableRows:(NSArray*)valuesTableRows
{
    arrayOfStrings = valuesTableRows;
}

- (void) heightForRowAtIndexPath:(CGFloat)height
{
    heightForRowAtIndexPath = height;
}

@end
