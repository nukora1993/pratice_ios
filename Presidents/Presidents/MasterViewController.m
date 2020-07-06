//
//  MasterViewController.m
//  Presidents
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

//@property NSMutableArray *objects;
@property NSMutableArray *presidents;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    BOOL fake = YES;
    NSDictionary *presidentInfo = nil;
    if (!fake) {
        NSString *path = [NSBundle.mainBundle pathForResource:@"PresidentsList" ofType:@"plist"];
        presidentInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    }else{
        // TO DO
        presidentInfo = @{
            @"presidents" : @[
                    @{
                        @"name" : @"Jefferson",
                        @"url" : @"https://baike.baidu.com/item/托马斯·杰斐逊?fromtitle=Jefferson&fromid=8604178"
                        
                    },
                    @{
                        @"name" : @"Trump",
                        @"url" : @"https://baike.baidu.com/item/唐纳德·特朗普/9916449?fromtitle=特朗普&fromid=20261083"
                    }
            ]
        };
    }
    
    _presidents = presidentInfo[@"presidents"];
    
    UISplitViewController *split = self.splitViewController;
    if (split) {
        NSArray *controllers = split.viewControllers;
        self.detailViewController = controllers[controllers.count - 1];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


//- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        controller.detailItem = object;
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//        self.detailViewController = controller;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (indexPath) {
            NSDictionary *object = self.presidents[indexPath.row];
            DetailViewController *controller = (DetailViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
            
            DetailViewController *oldController = self.detailViewController;
            if (oldController) {
                controller.languageString = oldController.languageString;
            }
            
            controller.detailItem = object;
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
            
            self.detailViewController = controller;
            
        }
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presidents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
    NSDictionary *president = self.presidents[indexPath.row];
    cell.textLabel.text = president[@"name"];
    
    return cell;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}


@end
