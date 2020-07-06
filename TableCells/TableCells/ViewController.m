//
//  ViewController.m
//  TableCells
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "NameAndColorCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString *cellTableIdentifier;
@property (nonatomic) NSArray *computers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

# pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _computers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellTableIdentifier forIndexPath:indexPath];
    NSDictionary *rowData = _computers[indexPath.row];
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    
    return cell;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cellTableIdentifier = @"CellTableIdentifier";
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [temp addObject:@{
            @"Name" : [NSString stringWithFormat:@"computer %d", i],
            @"Color" : @"Black"
        }];
    }
    _computers = [temp copy];
    
    // register cell reuse id
    [_tableView registerClass:[NameAndColorCell class] forCellReuseIdentifier:_cellTableIdentifier];
    
    UINib *xib = [UINib nibWithNibName:@"NameAndColorCell" bundle:nil];
    [_tableView registerNib:xib forCellReuseIdentifier:_cellTableIdentifier];
    _tableView.rowHeight = 65;
    
    
}




@end
