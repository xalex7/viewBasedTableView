//
//  ViewController.h
//  View Based TableView
//
//  Created by Fady Eid on 5/13/19.
//  Copyright © 2019 Fady Eid. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource, NSTabViewDelegate>

@property NSMutableArray* tableContent;

@property (strong) IBOutlet NSTableView *tableView;

- (IBAction)insertNewRow:(id)sender;
- (IBAction)removeSelectedRows:(id)sender;
- (IBAction)locateInFinder:(id)sender;



@end

//- (id)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex {
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
//
//    if (tableView == self.tableView) {
//        cell.textField.stringValue = [_bridge getInfoToDisplay:rowIndex];
//    } if (tableView == self.testsTable){
//        cell.textField.stringValue = _listArray [rowIndex];
//    }
//
//    return cell;
//}
