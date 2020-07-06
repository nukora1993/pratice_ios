//
//  MasterViewController.m
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TinyPixDocument.h"
#import "TinyPixUtils.h"

@interface MasterViewController ()

@property NSMutableArray *objects;

@property (nonatomic) NSArray *documentFileURLs;
@property (nonatomic) TinyPixDocument *chosenDocument;

@end

@implementation MasterViewController

- (void)chooseColor:(UISegmentedControl *)sender{
    NSUInteger selectedColorIndex = sender.selectedSegmentIndex;
    // set tint
    [self setTintColorForIndex:selectedColorIndex];
    
    NSUserDefaults *prefs = NSUserDefaults.standardUserDefaults;
    [prefs setInteger:selectedColorIndex forKey:@"selectedColorIndex"];
    [prefs synchronize];
}

- (void)setTintColorForIndex:(NSInteger)colorIndex{
    self.colorControl.tintColor = [TinyPixUtils getTintColorForIndex:colorIndex];
}

- (NSURL *)urlForFileName:(NSString *)fileName{
    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url;
    url = [urls.firstObject URLByAppendingPathComponent:fileName];
    
    return url;
}

- (void)reloadFiles{
    NSFileManager *fm = NSFileManager.defaultManager;
    NSURL *documentURL = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    
    NSArray *fileURLs = [fm contentsOfDirectoryAtURL:documentURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    NSArray *sortedFileURLs = [fileURLs sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSURL *file1URL = obj1;
        NSURL *file2URL = obj2;
        NSDictionary *attr1 = [fm attributesOfItemAtPath:file1URL.path error:nil];
        NSDictionary *attr2 = [fm attributesOfItemAtPath:file2URL.path error:nil];
        
        NSDate *file1Date = attr1[NSFileCreationDate];
        NSDate *file2Date = attr2[NSFileCreationDate];
        
        BOOL result = [file1Date compare:file2Date];
        
        return result;
        
    }];
    
    self.documentFileURLs = sortedFileURLs;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    NSUserDefaults *prefs = NSUserDefaults.standardUserDefaults;
    NSInteger selectedColorIndex = [prefs integerForKey:@"selectedColorIndex"];
    [self setTintColorForIndex:selectedColorIndex];
    self.colorControl.selectedSegmentIndex = selectedColorIndex;
    
    [self reloadFiles];
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose File Name" message:@"Enter a name for your new TinyPix Document" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *createAction = [UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields[0];
        [self createFileNamed:textField.text];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:createAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)createFileNamed:(NSString *)fileName{
    NSString *trimmedFiledName = [fileName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if (![trimmedFiledName isEqualToString:@""]) {
        NSString *targetName = [NSString stringWithFormat:@"%@.tinypix", trimmedFiledName];
        NSURL *saveURL = [self urlForFileName:targetName];
        self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:saveURL];
        [self.chosenDocument saveToURL:saveURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Save ok");
                [self reloadFiles];
                [self performSegueWithIdentifier:@"masterToDetail" sender:self];
            }else{
                NSLog(@"Save failed");
            }
        }];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        controller.detailItem = object;
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//        self.detailViewController = controller;
//    }
    
    UINavigationController *destination = segue.destinationViewController;
    DetailViewController *detailVC = (DetailViewController *)[destination topViewController];
    
    if (sender == self) {
        detailVC.detailItem = self.chosenDocument;
        
    }else{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath) {
            NSURL *docURL = [self documentFileURLs][indexPath.row];
            
            self.chosenDocument = [[TinyPixDocument alloc] initWithFileURL:docURL];
            [self.chosenDocument openWithCompletionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"Load ok");
                    detailVC.detailItem = self.chosenDocument;
                }else{
                    NSLog(@"Load failed");
                }
            }];
        }
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.objects.count;
    return self.documentFileURLs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    NSURL *fileURL = self.documentFileURLs[indexPath.row];
    
    cell.textLabel.text = [fileURL URLByDeletingPathExtension].lastPathComponent;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
