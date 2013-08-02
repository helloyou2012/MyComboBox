//
//  XUTableSectionController.h
//  MyComboBox
//
//  Created by HelloYou on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XUTableSectionController : NSObject

@property (nonatomic, strong) NSMutableArray *arrayItems;
@property (nonatomic, assign) BOOL open;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong, readonly) UIViewController *viewController;
@property (nonatomic, strong, readonly) UITableView *tableView;

- (id) initWithViewController:(UIViewController*) givenViewController;
//Can be subclassed for more control
- (UITableViewCell*) titleCell;
- (UITableViewCell*) contentCellForRow:(NSUInteger) row;
- (void) setAccessoryViewOnCell:(UITableViewCell*) cell;
- (void) updateTitleCell:(UITableViewCell*) cell;
- (void) updateAllCell;

- (NSUInteger) numberOfRow;
- (UITableViewCell *) cellForRow:(NSUInteger)row;

//Respond to cell selection
- (void) didSelectCellAtRow:(NSUInteger) row;
- (void) didSelectTitleCell;
- (void) didSelectContentCellAtRow:(NSUInteger) row;
@end
