//
//  ViewController.m
//  RFTapEditLabelDemo
//
//  Created by Rex Finn on 11/25/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "DemoTableViewController.h"

@interface DemoTableViewController ()

@property (strong, nonatomic) RFTapEditLabel *MaskLabel;
@property (strong, nonatomic) RFTapEditLabel *textLabel;
@property (strong, nonatomic) UIButton *revealMask;

@end

@implementation DemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RFTapEditLabel *tapLabel = [[RFTapEditLabel alloc] initWithFrame:CGRectMake(20, 100, 180, 31) secureTextEntry:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Labels/Cells" : @"Methods (Section 0, Row 1)";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 4 : 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RFTapEditCell *tapToEditCell = [[RFTapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    UITableViewCell *plainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            tapToEditCell = [[RFTapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secureTextEntry:NO];
            [tapToEditCell setPlaceholderText:@"Plain field. Uneditable."];
            [tapToEditCell  setLabelTextCustom:@"Plain field. Uneditable."];
            [tapToEditCell.tapTextLabel setEditable:NO];
            tapToEditCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 1) {
            tapToEditCell = [[RFTapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secureTextEntry:YES];
            tapToEditCell.tapTextLabel.text = @"Secure field. Uneditable.";
            [tapToEditCell updateTextForMask];
            [tapToEditCell.tapTextLabel setEditable:NO];
            tapToEditCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 2) {
            tapToEditCell = [[RFTapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secureTextEntry:NO];
            [tapToEditCell setPlaceholderText:@"Plain field. Tap to edit."];
            tapToEditCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            tapToEditCell = [[RFTapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier secureTextEntry:YES];
            [tapToEditCell setPlaceholderText:@"Secure field. Tap to edit."];
            tapToEditCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return tapToEditCell;
    }
    else {
        if (indexPath.row == 0) {
            plainCell.textLabel.text = @"Toggle editablity";
            plainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 1) {
            plainCell.textLabel.text = @"Toggle secure text label";
            plainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 2) {
            plainCell.textLabel.text = @"Toggle for time";
            plainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 3) {
            plainCell.textLabel.text = @"Toggle for time with blocks";
            plainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            plainCell.textLabel.text = @"Custom mask length (ex. 3)";
            // plainCell.detailTextLabel.text = @"Apply before toggling...";
            plainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return plainCell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            RFTapEditCell *cell = (RFTapEditCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.tapTextLabel toggleEditable];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else if (indexPath.row == 1) {
            RFTapEditCell *cell = (RFTapEditCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.tapTextLabel toggleMask];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else if (indexPath.row == 2) {
                RFTapEditCell *cell = (RFTapEditCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                [cell.tapTextLabel toggleMaskForTime:5];
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else if (indexPath.row == 3) {
            RFTapEditCell *cell = (RFTapEditCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.tapTextLabel toggleMaskForTime:5 onToggle:^{
                cell.tapTextLabel.textColor = [UIColor redColor];
            }
            completion:^{
                cell.tapTextLabel.textColor = [UIColor blackColor];
            }];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else if (indexPath.row == 4) {
            RFTapEditCell *cell = (RFTapEditCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.tapTextLabel setMaskWithLength:3];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

@end
