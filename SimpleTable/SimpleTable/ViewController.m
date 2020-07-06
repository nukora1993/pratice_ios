//
//  ViewController.m
//  SimpleTable
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *dwarves;
@property (nonatomic) NSString *simpleTableIdentifier;

@end

@implementation ViewController
#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dwarves.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_simpleTableIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_simpleTableIdentifier];
        // image will invalid
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:_simpleTableIdentifier];
    }
    
    
    
    // add image
    UIImage *image = [UIImage imageNamed:@"pdd"];
    cell.imageView.image = image;
    
    UIImage *highlightedImage = [UIImage imageNamed:@"baidu"];
    cell.imageView.highlightedImage = highlightedImage;
    
    if (indexPath.row < 7) {
        cell.detailTextLabel.text = @"baidu";
    }else{
        cell.detailTextLabel.text = @"pdd";
    }
    
    cell.textLabel.text = _dwarves[indexPath.row];
    // change font, but now, the table view is very smart and can auto change row height
    cell.textLabel.font = [UIFont boldSystemFontOfSize:100];
    
    return cell;
}

# pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row % 4;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    return indexPath.row == 0 ? nil : indexPath;
    if (indexPath.row == 0) {
        return nil;
    }else{
        if (indexPath.row % 2 == 0) {
            return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        }else{
            return indexPath;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *rowValue = _dwarves[indexPath.row];
    NSString *message = [NSString stringWithFormat:@"You selected %@", rowValue];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Row selected" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes I did" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? 120 : 70;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [temp addObject:[NSString stringWithFormat:@"Item %d", i]];
        
    }
    
    _dwarves = [temp copy];
    
    _simpleTableIdentifier = @"SimpleTableIdentifier";
}


@end
