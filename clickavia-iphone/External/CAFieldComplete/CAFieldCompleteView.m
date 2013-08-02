//
//  CAFieldComplete.m
//  cafieldcomplete
//
//  Created by macmini1 on 29.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import "CAFieldCompleteView.h"

@implementation CAFieldCompleteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseSetup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        [self baseSetup];
    }
    return self;
}
- (void) baseSetup
{
    oldFrame = CGRectZero;
    tableGradientLayer = [CAGradientLayer new];
    tableGradientLayer.colors = [[CAFCStyle sharedStyle] gradientColorsForTable];

    _isReturn = NO;
    textFieldActive = NO;
    destinations = [NSArray new];
    textField = [[CAFCTextField alloc] init];
    textField.delegate = self;
    textField.frame = CGRectMake(0, 0, 320/2-20, 30);
    autocompleteTable = [[UITableView alloc] init];
    autocompleteTable.backgroundColor = [UIColor clearColor];
    autocompleteTable.dataSource = self;
    autocompleteTable.delegate = self;
    autocompleteTable.layer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTable];

    triangleView = [CAFCTriangleView new];
    triangleView.frame = CGRectMake(0, 50, 15, 15);
    tableBackground = [[UIImageView alloc] initWithImage:[[CAFCStyle sharedStyle] imageForBackgroundForTable]];

    tableBackground.layer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTable];
    tableGradientLayer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTable];
    [tableBackground.layer addSublayer:tableGradientLayer];

    [self addSubview:triangleView];
    [self addSubview:textField];
    [self addSubview:autocompleteTable];
    [self addSubview:tableBackground];


    [autocompleteTable setHidden:YES];
    [triangleView setHidden:YES];
    [tableBackground setHidden:YES];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if(CGRectEqualToRect(oldFrame,CGRectZero))
    {
        oldFrame = self.frame;
    }

    self.backgroundColor = [UIColor clearColor];
    if(_isReturn)
    {
        autocompleteTable.frame = CGRectMake(0, 65, self.superview.frame.size.width, self.superview.frame.size.height);
        triangleView.frame = CGRectMake(textField.frame.origin.x+textField.frame.size.width*0.4,
                                        textField.frame.origin.y+textField.frame.size.height,
                                        55, 45);
        tableBackground.frame = autocompleteTable.frame;
        tableGradientLayer.frame = tableBackground.bounds;
    }
    else
    {
        
        autocompleteTable.frame = CGRectMake(0, 65, self.superview.frame.size.width, self.superview.frame.size.height);
        triangleView.frame = CGRectMake(textField.frame.origin.x,
                                        textField.frame.origin.y+textField.frame.size.height,
                                        55, 45);

        tableBackground.frame = autocompleteTable.frame;
        tableGradientLayer.frame = tableBackground.bounds;

    }

    
    self.userInteractionEnabled = YES;
    [textField becomeActive:textFieldActive];

}
- (void)resizeMe:(BOOL)full
{
    if(full)
    {

        textField.frame = CGRectMake(oldFrame.origin.x,oldFrame.origin.y, 320/2-20, 30);
        self.frame = CGRectMake(0,0,self.superview.bounds.size.width,self.superview.bounds.size.height);
        textFieldActive = YES;

    }
    else
    {

        textField.frame = CGRectMake(0, 0, 320/2-20, 30);
        self.frame = oldFrame;
        textFieldActive = NO;
    }
    tableBackground.frame = autocompleteTable.frame;
    tableGradientLayer.frame = tableBackground.bounds;
    
}
#pragma mark UITableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return destinations.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    CAFCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(cell==nil)
    {
        cell = [[CAFCTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    Destination *currentDestination = (Destination*)[destinations objectAtIndex:indexPath.row];
    
    cell.destinationName.text = currentDestination.cityTitle;
    cell.destinationCode.text = currentDestination.cityCode;
    return cell;
}
- (void) setAutocompleteData:(NSArray *)autocompleteArray
{

    [self bringSubviewToFront:autocompleteTable];
    destinations = autocompleteArray;
    [autocompleteTable reloadData];
}
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Destination *currentDestination = (Destination*)[destinations objectAtIndex:indexPath.row];
    [textField setDestination:currentDestination];
    [self resizeMe:NO];
    [tableBackground setHidden:YES];
    [autocompleteTable setHidden:YES];
    [triangleView setHidden:YES];
    [_delegate fieldCompleteView:self selectedDestination:currentDestination];
    [autocompleteTable deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark CATextFieldCompleteDelegate
- (void)textFieldComplete:(CAFCTextField*) textField changeString:(NSString*)oldText withString:(NSString*)newText
{
    [_delegate fieldCompleteView:self textChanged:newText];
}
- (void)textFieldCompleteDidBeginEditing:(CAFCTextField*)textField
{
    UIView *parentView = self.superview;
    [parentView sendSubviewToBack:self];
    
    
    [self resizeMe:YES];
    tableBackground.hidden = NO;
    autocompleteTable.hidden = NO;
    triangleView.hidden = NO;
    [parentView bringSubviewToFront:self];
    for(UIView *view in parentView.subviews)
    {
        if([view isKindOfClass:self.class]&&self!=view)
        {
            [parentView bringSubviewToFront:view];
        }
    }
    [self bringSubviewToFront:autocompleteTable];
    [_delegate fieldCompleteViewBeginEditing:self];
}
- (void)textFieldCompleteDidEndEditing:(CAFCTextField*) textField
{
    autocompleteTable.hidden = YES;
    triangleView.hidden = YES;
    tableBackground.hidden = YES;
    [self resizeMe:NO];
}
- (void)textFieldCompleteClear:(CAFCTextField*)textField
{
    
}
- (void)textFieldCompleteReturn:(CAFCTextField*)textField
{
    [self resizeMe:NO];
}
- (NSString*) text
{
    return textField.text;
}
@end
