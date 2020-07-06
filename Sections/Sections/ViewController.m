//
//  ViewController.m
//  Sections
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultsController.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic) NSString *sectionsTableIdentifier;
@property (nonatomic) NSDictionary *names;
@property (nonatomic) NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) UISearchController *searchController;
@end

@implementation ViewController

#pragma mark -table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = _keys[section];
    NSArray *nameSection = _names[key];
    return nameSection.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _keys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_sectionsTableIdentifier forIndexPath:indexPath];
    NSString *key = _keys[indexPath.section];
    NSArray *nameSection = _names[key];
    cell.textLabel.text = nameSection[indexPath.row];
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Boolean fake = YES;
    
    
    _sectionsTableIdentifier = @"SectionsTableIdentifier";
    
    NSDictionary *namesDict = nil;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:_sectionsTableIdentifier];
    if (!fake) {
        NSString *path =[NSBundle.mainBundle pathForResource:@"sortednames" ofType:@"plist"];
        namesDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }else{
        NSString *A = @"A";
        int ascii_A = [A characterAtIndex:0];
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        for (int i = 0; i < 26; i++) {
            int curAscii = ascii_A + i;
            NSString *curChar = [NSString stringWithFormat:@"%c", curAscii];
            temp[curChar] = [NSMutableArray array];
            
            for (int j =0; j < 10; j++) {
                NSString *tempItem = [NSString stringWithFormat:@"%@ %d", curChar, j];
                [temp[curChar] addObject:tempItem];
            }
        }
        
        namesDict = temp;
    }
  
    _names = namesDict;
    _keys = [namesDict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    // for search
    SearchResultsController *resultsController = [[SearchResultsController alloc] init];
    resultsController.names = _names;
    resultsController.keys =_keys;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    
    UISearchBar *searchBar = _searchController.searchBar;
    searchBar.scopeButtonTitles = @[@"All", @"Short", @"Long"];
    searchBar.placeholder = @"Enter a search Item";
    [searchBar sizeToFit];
    _tableView.tableHeaderView = searchBar;
    _searchController.searchResultsUpdater = resultsController;
    
    
    
}


@end
