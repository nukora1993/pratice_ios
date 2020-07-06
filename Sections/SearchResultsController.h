//
//  SearchResultsController.h
//  Sections
//
//  Created by nuko on 2020/6/27.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

static int longNameSize = 6;
static int shortNameButtonIndex = 2;
static int longNameButtonIndex = 2;

@interface SearchResultsController : UITableViewController <UISearchResultsUpdating>

//@property (nonatomic) NSString *sectionsTableIdentifier;
@property (nonatomic) NSDictionary *names;
@property (nonatomic) NSArray *keys;
@property (nonatomic) NSMutableArray *filteredNames;
@end

NS_ASSUME_NONNULL_END
