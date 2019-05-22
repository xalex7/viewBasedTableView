//
//  ViewController.m
//  View Based TableView
//
//  Created by Fady Eid on 5/13/19.
//  Copyright © 2019 Fady Eid. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableContent = [[NSMutableArray alloc] init];
    
    NSString *path = @"/Users/fady/Desktop/Flags";
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator* directoryEnum = [fileManager enumeratorAtPath:path];
    
    NSString* file;
    
    while (file = [directoryEnum nextObject]) {
        NSString* filePath = [path stringByAppendingFormat:@"/%@", file];
        NSDictionary* obj = @{@"image": [[NSImage alloc] initByReferencingFile:filePath], @"name": [file stringByDeletingPathExtension], @"filePath": filePath};
        [_tableContent addObject:obj];
    }
    
    [_tableView setDataSource:self];
    [_tableView setDelegate:(id)self];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return [_tableContent count];
}

- (NSView*)tableView:(NSTableView*)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    NSDictionary* flag = _tableContent[row];
    NSString* identifier = [tableColumn identifier];
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView* cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
        [cellView.textField setStringValue:flag[@"name"]];
        [cellView.imageView setImage:flag[@"image"]];
        return cellView;
    }
    return nil;
}

- (IBAction)insertNewRow:(id)sender {
    NSDictionary *obj = @{@"name": @"Temp Row Name"};
    NSInteger index = [_tableView selectedRow];
    index++; // This is for: If you have nothing selected, it will return -1 with ++ it'll be 1. if you have selected row 1 with ++ the new object will be added right after the selected row
    [_tableContent insertObject:obj atIndex:index];
    //The table content is an Array
    
    [_tableView beginUpdates]; // Will group animations;
    [_tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:index] withAnimation:NSTableViewAnimationEffectFade];
    [_tableView scrollRowToVisible:index]; // This will jump to where new rows are being added;
    [_tableView endUpdates]; // Will group animations;
}

- (IBAction)removeSelectedRows:(id)sender {
    NSIndexSet* indexes = [_tableView selectedRowIndexes];
    //^ Will get all the selected rows;
    [_tableContent removeObjectsAtIndexes:indexes];
    [_tableView removeRowsAtIndexes:indexes withAnimation:NSTableViewAnimationSlideDown];
}

- (IBAction)locateInFinder:(id)sender {
    NSInteger selectedRow = [_tableView rowForView:sender];
    NSDictionary* obj = _tableContent[selectedRow];
    [[NSWorkspace sharedWorkspace]selectFile:obj[@"filePath"] inFileViewerRootedAtPath:nil];
}


@end
