//
//  ViewController.m
//  DialogViewer
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "ContentCell.h"
#import "HeaderCell.h"

@interface ViewController ()

@property (nonatomic) NSArray *sections;

@end

@implementation ViewController

# pragma mark - collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *words = [self wordsInSections:section];
    return words.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *words = [self wordsInSections:indexPath.section];
    
    ContentCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.maxWidth = collectionView.bounds.size.width;
    cell.text = words[indexPath.row];
    
    return cell;
}

- (NSArray *)wordsInSections:(NSInteger)section{
    NSString *content = _sections[section][@"content"];
    NSCharacterSet *spaces = NSCharacterSet.whitespaceAndNewlineCharacterSet;
    NSArray *words = [content componentsSeparatedByCharactersInSet:spaces];
    
    return words;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sections = @[
        @{
            @"header" : @"First Witch",
            @"content" : @"Hey when will the three of us meet up later?"
        },
        @{
            @"header" : @"Second Witch",
            @"content" : @"When everything's straightened out"
        },
        @{
            @"header" : @"Third Witch",
            @"content" : @"I don't care what you say I don't care what you say I don't care what you say I don't care what you say I don't care what you say "
        }
    ];
    
    [self.collectionView registerClass:ContentCell.class forCellWithReuseIdentifier:@"CONTENT"];
    
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.top = 20;
    self.collectionView.contentInset = contentInset;
    
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
    
    [self.collectionView registerClass:HeaderCell.class forCellWithReuseIdentifier:@"HEADER"];
    
    flow.headerReferenceSize = CGSizeMake(100, 25);
    
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        cell.maxWidth = collectionView.bounds.size.width;
        cell.text = _sections[indexPath.section][@"header"];
        
        return cell;
    }
    abort();
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *words = [self wordsInSections:indexPath.section];
    CGSize size = [ContentCell sizeForContentString:words[indexPath.row] forMaxWidth:self.collectionView.bounds.size.width];
    
    return size;
}


@end
