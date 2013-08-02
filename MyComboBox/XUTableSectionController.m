//
//  XUTableSectionController.m
//  MyComboBox
//
//  Created by HelloYou on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XUTableSectionController.h"

@implementation XUTableSectionController

@synthesize arrayItems=_arrayItems;
@synthesize open=_open;
@synthesize selectedIndex=_selectedIndex;
@synthesize viewController=_viewController;
@synthesize tableView=_tableView;

- (id) initWithViewController:(UIViewController*) givenViewController
{
    if ((self = [super init])) {
        if (![givenViewController respondsToSelector:@selector(tableView)]) {
            //The view controller MUST have a tableView proprety
            [NSException raise:@"Wrong view controller" 
                        format:@"The passed view controller to GCRetractableSectionController must respond to the tableView proprety"];
        }
		_viewController = givenViewController;
		_open = NO;
        _selectedIndex=-1;
        _arrayItems=[[NSMutableArray alloc] initWithObjects:@"item1",@"item2",@"item3", nil];
        //_arrayItems=[[NSMutableArray alloc] init];
	}
	return self;
}
#pragma mark -
#pragma mark Getters

- (UITableView*) tableView {
	return [self.viewController performSelector:@selector(tableView)];
}

- (NSUInteger) numberOfRow {
    return (self.open) ? self.arrayItems.count + 1 : 1;
}

- (NSUInteger) contentNumberOfRow {
	return self.arrayItems.count;
}

#pragma mark -
#pragma mark Cells

- (UITableViewCell *) cellForRow:(NSUInteger)row {
	UITableViewCell* cell = nil;
	
	if (row == 0) cell = [self titleCell];
	else cell = [self contentCellForRow:row - 1];
	
	return cell;
}

- (UITableViewCell *) titleCell {
	NSString* titleCellIdentifier = @"TitleCell";
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:titleCellIdentifier];
	}
	
	cell.textLabel.text = @"Title:";
	
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [self setAccessoryViewOnCell:cell];
	return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row {
	NSString* contentCellIdentifier = @"ContentCell";
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:contentCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	if (_selectedIndex==row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	cell.textLabel.text = [_arrayItems objectAtIndex:row];
    cell.indentationLevel=1;
    cell.indentationWidth=20.0f;
	
	return cell;
}

- (void) setAccessoryViewOnCell:(UITableViewCell*) cell {
	NSString* path = nil;
	if (self.open) {
		path = @"UpAccessory";
        cell.textLabel.textColor = [UIColor blueColor];
	}	
	else {
		path = @"DownAccessory";
		cell.textLabel.textColor = [UIColor blackColor];
	}
	
	UIImage* accessoryImage = [UIImage imageNamed:path];
	
	UIImageView* imageView;
	if (cell.accessoryView != nil) {
		imageView = (UIImageView*) cell.accessoryView;
		imageView.image = accessoryImage;
    }
	else {
		imageView = [[UIImageView alloc] initWithImage:accessoryImage];
		cell.accessoryView = imageView;
	}
    [self updateTitleCell:cell];
}

- (void) updateTitleCell:(UITableViewCell*) cell
{
    if (_selectedIndex>=0) {
        cell.detailTextLabel.text = [_arrayItems objectAtIndex:_selectedIndex];
    }else{
        cell.detailTextLabel.text = @"";
    }
}

- (void) updateAllCell
{
    if (self.contentNumberOfRow != 0){
        NSIndexPath* indexPath=[self.tableView indexPathForSelectedRow];
        if (indexPath.row!=0) {
            indexPath=[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        }
        [self setAccessoryViewOnCell:[self.tableView cellForRowAtIndexPath:indexPath]];
    }
	
	NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	NSUInteger section = indexPath.section;
	NSUInteger contentCount = self.contentNumberOfRow;
	
	[self.tableView beginUpdates];
	
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (self.open) [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
	else [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
	
	[self.tableView endUpdates];
	
	if (self.open) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Select Cell

- (void) didSelectCellAtRow:(NSUInteger)row {
	if (row == 0) [self didSelectTitleCell];
	else [self didSelectContentCellAtRow:row - 1];
    [self updateAllCell];
}

- (void) didSelectTitleCell {
	self.open = !self.open;
}

- (void) didSelectContentCellAtRow:(NSUInteger)row
{
    if (_selectedIndex==row) {
        _selectedIndex=-1;
        _open=NO;
    }else{
        _selectedIndex=row;
        _open=NO;
    }
}
@end
