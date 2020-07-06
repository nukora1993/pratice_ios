//
//  FontLListViewController.m
//  Fonts
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "FontListViewController.h"
#import "FavoritesList.h"
#import "FontSizesViewController.h"
#import "FontInfoViewController.h"

static NSString * const cellIdentifier = @"FontName";

@interface FontListViewController ()

@property (nonatomic) CGFloat cellPointSize;
@end

@implementation FontListViewController



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return _showFavorites;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_showFavorites) {
        return;
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *favorite = _fontNames[indexPath.row];
        
        [[FavoritesList sharedFavoriteList] removeFavorite:favorite];
        _fontNames = [FavoritesList sharedFavoriteList].favorites;
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell *tableViewCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tableViewCell];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    
    if ([segue.identifier isEqualToString:@"ShowFontSize"]) {
        FontSizesViewController *sizeVC = segue.destinationViewController;
        sizeVC.title = font.fontName;
        sizeVC.font = font;
    }else{
        FontInfoViewController *infoVC =segue.destinationViewController;
        infoVC.title = font.fontName;
        infoVC.font = font;
        infoVC.favorite = [[FavoritesList sharedFavoriteList].favorites containsObject:font.fontName];
        NSLog(@"");
    }
    
    
    
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fontName = _fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:_cellPointSize];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_showFavorites) {
        _fontNames = FavoritesList.sharedFavoriteList.favorites;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _cellPointSize = preferredTableViewFont.pointSize;
    self.tableView.estimatedRowHeight = _cellPointSize;
    
    if (_showFavorites) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = _fontNames[indexPath.row];
    cell.detailTextLabel.text = _fontNames[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [[FavoritesList sharedFavoriteList] moveItemFromIndex:sourceIndexPath.row ToIndex:destinationIndexPath.row];
    
    _fontNames = [FavoritesList sharedFavoriteList].favorites;
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
