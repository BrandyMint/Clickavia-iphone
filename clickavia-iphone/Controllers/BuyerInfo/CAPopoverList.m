//
//  CAPopoverList.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPopoverList.h"

@interface CAPopoverList ()
{
    NSArray* array;
    float height;
}
@end

@implementation CAPopoverList

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(id)initWithStyle:(UITableViewStyle)style arrayValues:(NSArray*)arrayValues
{
    self = [super initWithStyle:style];
    if (self) {
        array = arrayValues;
    }
    return self;
}

-(void)title:(NSString* )title
{
    self.title = title;
}

-(void)heightRow:(float)heightRow
{
    height = heightRow;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate popoverListdidSelectRowAtIndexPath:indexPath];
}

@end
