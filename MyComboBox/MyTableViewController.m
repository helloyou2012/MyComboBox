//
//  MyTableViewController.m
//  MyComboBox
//
//  Created by HelloYou on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewController.h"
#import "XUTableSectionController.h"


@implementation MyTableViewController

@synthesize retractableControllers=_retractableControllers;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _retractableControllers=[[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {
        XUTableSectionController* simpleController = [[XUTableSectionController alloc] initWithViewController:self];
        [_retractableControllers addObject:simpleController];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _retractableControllers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XUTableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return [sectionController numberOfRow];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XUTableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XUTableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

@end
