//
//  SearchResultsController.m
//  Sections
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "SearchResultsController.h"

NSString* const sectionsTableIdentifier = @"SectionTableIdentifier";

@interface SearchResultsController () 

@end

@implementation SearchResultsController

# pragma mark - search results updating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    NSLog(@"i am updating %@", searchString);
    if (searchString) {
        NSInteger buttonIndex = searchController.searchBar.selectedScopeButtonIndex;
        [_filteredNames removeAllObjects];
        
        if (![searchString isEqualToString:@""]) {
            NSPredicate *filter = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                NSString *name = (NSString*)evaluatedObject;
                NSInteger nameLength = name.length;
                if ((buttonIndex == shortNameButtonIndex
                    && nameLength >= longNameSize)
                    || (buttonIndex == longNameButtonIndex
                        && nameLength <= longNameSize)){
                    return false;
                }
                
                NSRange range = [name rangeOfString:searchString options:NSCaseInsensitiveSearch];
                
                return range.length != 0;
            }];
            
            for (NSString *key in _keys) {
                NSArray *namesForKey = _names[key];
                NSArray *matches = [namesForKey filteredArrayUsingPredicate:filter];
                [_filteredNames addObjectsFromArray:matches];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    
//    _sectionsTableIdentifier = @"SectionsTableIdentifier";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionsTableIdentifier];
    
    _filteredNames = [NSMutableArray array];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _filteredNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
    cell.textLabel.text = _filteredNames[indexPath.row];
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
